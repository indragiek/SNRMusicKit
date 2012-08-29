//
//  SMKiTunesContentSource.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-21.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SMKiTunesContentSource.h"
#import "SMKiTunesSyncOperation.h"
#import "SMKAVQueuePlayer.h"

#import "NSBundle+SMKAdditions.h"
#import "NSURL+SMKAdditions.h"
#import "NSError+SMKAdditions.h"
#import "NSManagedObjectContext+SMKAdditions.h"

@interface SMKiTunesContentSource ()
@property (nonatomic, strong) NSOperationQueue *operationQueue;
@end

static NSUInteger const SMKiTunesContentSourceDefaultBatchSize = 20;

@implementation SMKiTunesContentSource {
    dispatch_queue_t _backgroundQueue;
    dispatch_semaphore_t _semaphore;
}

- (id)init
{
    if ((self = [super init])) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_applicationWillTerminate:) name:NSApplicationWillTerminateNotification object:[NSApplication sharedApplication]];
        self.operationQueue = [NSOperationQueue new];
        [self.operationQueue setMaxConcurrentOperationCount:1];
        _backgroundQueue = dispatch_queue_create("com.indragie.SNRMusicKit.SNRiTunesContentSource", DISPATCH_QUEUE_SERIAL);
        self.syncPlaylists = YES;
        [self sync];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (_backgroundQueue)
        dispatch_release(_backgroundQueue);
    if (_semaphore)
        dispatch_release(_semaphore);
}

#pragma mark - SMKContentSource

- (NSString *)name { return @"iTunes"; }

+ (Class)predicateClass { return [NSPredicate class]; }

- (void)fetchPlaylistsWithSortDescriptors:(NSArray *)sortDescriptors
                                predicate:(NSPredicate *)predicate
                        completionHandler:(void(^)(NSArray *playlists, NSError *error))handler
{
    __weak SMKiTunesContentSource *weakSelf = self;
    dispatch_async(_backgroundQueue, ^{
        SMKiTunesContentSource *strongSelf = weakSelf;
        [strongSelf _createSemaphoreAndWait];
        [strongSelf.backgroundQueueObjectContext SMK_asyncFetchObjectIDsWithEntityName:SMKiTunesEntityNamePlaylist sortDescriptors:sortDescriptors predicate:predicate batchSize:[strongSelf.backgroundQueueObjectContext defaultFetchBatchSize] fetchLimit:0 completionHandler:^(NSArray *results, NSError *error) {
            NSArray *objects = [strongSelf.mainQueueObjectContext SMK_objectsFromObjectIDs:results];
            if (handler) handler(objects, error);
        }];
    });
}
 
- (void)executeFetchRequest:(NSFetchRequest *)request
          completionHandler:(void(^)(NSArray *playlists, NSError *error))handler
{
    __weak SMKiTunesContentSource *weakSelf = self;
    dispatch_async(_backgroundQueue, ^{
        SMKiTunesContentSource *strongSelf = weakSelf;
        [strongSelf _createSemaphoreAndWait];
        [strongSelf.backgroundQueueObjectContext SMK_asyncFetchWithFetchRequest:request completionHandler:^(NSArray *results, NSError *error) {
            NSArray *objects = [strongSelf.mainQueueObjectContext SMK_objectsFromObjectIDs:results];
            if (handler) handler(objects, error);
        }];
    });
}


- (void)deleteStore
{
    _mainQueueObjectContext = nil;
    _backgroundQueueObjectContext = nil;
    _persistentStoreCoordinator = nil;
    NSURL *url = [self _storeURL];
    NSError *error = nil;
    [[NSFileManager defaultManager] removeItemAtURL:url error:&error];
    if (error)
        NSLog(@"Error removing Core Data store at URL %@: %@, %@", url, error, [error userInfo]);
}

#pragma mark - Notifications

- (void)_applicationWillTerminate:(NSNotification *)notification
{
    [self.backgroundQueueObjectContext performBlockAndWait:^{
        [self.backgroundQueueObjectContext SMK_saveChanges];
    }];
}

#pragma mark - Sync

- (void)sync
{
    // There's a sync already happening
    if ([_operationQueue operationCount] != 0)
        return;
    
    __weak SMKiTunesContentSource *weakSelf = self;
    SMKiTunesSyncOperation *operation = [SMKiTunesSyncOperation new];
    [operation setCompletionBlock:^(SMKiTunesSyncOperation *op, NSUInteger count) {
        SMKiTunesContentSource *strongSelf = weakSelf;
        if (strongSelf->_semaphore) {
            dispatch_semaphore_signal(strongSelf->_semaphore);
        }
    }];
    [operation setContentSource:self];
    [operation setSyncPlaylists:self.syncPlaylists];
    [_operationQueue addOperation:operation];
}

#pragma mark - Private

- (void)_createSemaphoreAndWait
{
    if ([self.operationQueue operationCount] != 0) {
        _semaphore = dispatch_semaphore_create(0);
        dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
        dispatch_release(_semaphore);
    }
}

#pragma mark - Core Data Boilerplate

- (NSURL *)_storeURL
{
    NSURL *applicationFilesDirectory = [NSURL SMK_applicationSupportFolder];
    return [applicationFilesDirectory URLByAppendingPathComponent:@"SMKiTunesContentSource.storedata"];
}

- (SMKManagedObjectContext *)mainQueueObjectContext
{
    if (_mainQueueObjectContext) {
        return _mainQueueObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        NSError *error = [NSError SMK_errorWithCode:SMKCoreDataErrorFailedToInitializeStore description:[NSString stringWithFormat:@"Failed to initialize the store for class: %@", NSStringFromClass([self class])]];
        SMKGenericErrorLog(nil, error);
        return nil;
    }
    _mainQueueObjectContext = [[SMKManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_mainQueueObjectContext setPersistentStoreCoordinator:coordinator];
    [_mainQueueObjectContext setUndoManager:nil];
    [_mainQueueObjectContext setSMK_contentSource:self];
    return _mainQueueObjectContext;
}

- (NSManagedObjectContext *)backgroundQueueObjectContext
{
    if (_backgroundQueueObjectContext) {
        return _backgroundQueueObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        NSError *error = [NSError SMK_errorWithCode:SMKCoreDataErrorFailedToInitializeStore description:[NSString stringWithFormat:@"Failed to initialize the store for class: %@", NSStringFromClass([self class])]];
        SMKGenericErrorLog(nil, error);
        return nil;
    }
    _backgroundQueueObjectContext = [[SMKManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [_backgroundQueueObjectContext setParentContext:[self mainQueueObjectContext]];
    [_backgroundQueueObjectContext setUndoManager:nil];
    [_backgroundQueueObjectContext setSMK_contentSource:self];
    return _backgroundQueueObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle SMK_frameworkBundle] URLForResource:@"SMKiTunesDataModel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }
    
    NSManagedObjectModel *mom = [self managedObjectModel];
    if (!mom) {
        NSLog(@"%@:%@ No model to generate a store from", [self class], NSStringFromSelector(_cmd));
        return nil;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *applicationFilesDirectory = [NSURL SMK_applicationSupportFolder];
    NSError *error = nil;
    
    NSDictionary *properties = [applicationFilesDirectory resourceValuesForKeys:@[NSURLIsDirectoryKey] error:&error];
    
    if (!properties) {
        BOOL ok = NO;
        if ([error code] == NSFileReadNoSuchFileError) {
            ok = [fileManager createDirectoryAtPath:[applicationFilesDirectory path] withIntermediateDirectories:YES attributes:nil error:&error];
        }
        if (!ok) {
            SMKGenericErrorLog(@"Error reading attributes of application files directrory", error);
            return nil;
        }
    } else {
        if (![properties[NSURLIsDirectoryKey] boolValue]) {
            NSString *failureDescription = [NSString stringWithFormat:@"Expected a folder to store application data, found a file (%@).", [applicationFilesDirectory path]];
            error = [NSError SMK_errorWithCode:SMKCoreDataErrorDataStoreNotAFolder description:failureDescription];
            SMKGenericErrorLog(@"Error creating data store", error);
            return nil;
        }
    }
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    if (![coordinator addPersistentStoreWithType:NSXMLStoreType configuration:nil URL:[self _storeURL] options:nil error:&error]) {
        SMKGenericErrorLog(@"Error adding persistent store", error);
        return nil;
    }
    _persistentStoreCoordinator = coordinator;
    
    return _persistentStoreCoordinator;
}
@end
