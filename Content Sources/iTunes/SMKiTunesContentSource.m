//
//  SMKiTunesContentSource.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-21.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SMKiTunesContentSource.h"
#import "SMKiTunesConstants.h"

#import "NSBundle+SMKAdditions.h"
#import "NSURL+SMKAdditions.h"
#import "NSError+SMKAdditions.h"
#import "NSManagedObjectContext+SMKAdditions.h"
#import "SMKiTunesSyncOperation.h"

@interface SMKiTunesContentSource ()
// Notifications
- (void)_applicationWillTerminate:(NSNotification *)notification;
@end

@implementation SMKiTunesContentSource {
    NSOperationQueue *_operationQueue;
    dispatch_semaphore_t _waiter;
    dispatch_queue_t _backgroundQueue;
}
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (id)init
{
    if ((self = [super init])) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_applicationWillTerminate:) name:NSApplicationWillTerminateNotification object:[NSApplication sharedApplication]];
        _operationQueue = [NSOperationQueue new];
        _backgroundQueue = dispatch_queue_create("com.indragie.SNRMusicKit.SNRiTunesContentSource", DISPATCH_QUEUE_SERIAL);
        [self sync];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (_waiter)
        dispatch_release(_waiter);
    if (_backgroundQueue)
        dispatch_release(_backgroundQueue);
}

#pragma mark - SMKContentSource

- (NSString *)name { return @"iTunes"; }

+ (BOOL)supportsBatching { return YES; }

- (NSArray *)playlistsWithSortDescriptors:(NSArray *)sortDescriptors
                                batchSize:(NSUInteger)batchSize
                               fetchLimit:(NSUInteger)fetchLimit
                                predicate:(NSPredicate *)predicate
                                withError:(NSError **)error
{
    // If the operation is already running, then create a semaphore to force it to wait till it finishes
    if ([_operationQueue operationCount] != 0 && !_waiter) {
        _waiter = dispatch_semaphore_create(0);
        dispatch_semaphore_wait(_waiter, DISPATCH_TIME_FOREVER);
    }
    // Release the semaphore after we're done with it
    if (_waiter)
        dispatch_release(_waiter);
    // Fetch the objects and return
    return [self.managedObjectContext SMK_fetchWithEntityName:SMKiTunesEntityNamePlaylist
                                              sortDescriptors:sortDescriptors
                                                    predicate:predicate
                                                    batchSize:batchSize
                                                   fetchLimit:fetchLimit error:error];
}

- (void)fetchPlaylistsWithSortDescriptors:(NSArray *)sortDescriptors
                                batchSize:(NSUInteger)batchSize
                               fetchLimit:(NSUInteger)fetchLimit
                                predicate:(NSPredicate *)predicate
                        completionHandler:(void(^)(NSArray *playlists, NSError *error))handler
{
    __block SMKiTunesContentSource *weakSelf = self;
    dispatch_async(_backgroundQueue, ^{
        SMKiTunesContentSource *strongSelf = weakSelf;
        __block BOOL noSempahore = NO;
        // Check on the main queue if a sync operation is already running
        // If so, create a semaphore 
        dispatch_sync(dispatch_get_main_queue(), ^{
            noSempahore = ![strongSelf->_operationQueue operationCount] != 0 && !strongSelf->_waiter;
            if (noSempahore)
                _waiter = dispatch_semaphore_create(0);
        });
        // Now we tell the semaphore to wait on the background queue until the sync is over
        // Hopefully dispatch_semaphore is thread-safe?
        if (noSempahore)
            dispatch_semaphore_wait(strongSelf->_waiter, DISPATCH_TIME_FOREVER);
        // Once that's done, tell the MOC on the main queue to run an asynchronous fetch
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (strongSelf->_waiter)
                dispatch_release(strongSelf->_waiter);
            [strongSelf.managedObjectContext SMK_asyncFetchWithEntityName:SMKiTunesEntityNamePlaylist sortDescriptors:sortDescriptors predicate:predicate batchSize:batchSize fetchLimit:fetchLimit completionHandler:handler];
        });
    });
}

- (void)deleteStore
{
    _managedObjectContext = nil;
    _persistentStoreCoordinator = nil;
    NSURL *url = [applicationFilesDirectory URLByAppendingPathComponent:@"SMKiTunesContentSource.storedata"];
    NSError *error = nil;
    [[NSFileManager defaultManager] removeItemAtURL:url error:&error];
    if (error)
        NSLog(@"Error removing Core Data store at URL %@: %@, %@", url, error, [error userInfo]);
}

#pragma mark - Notifications

- (void)_applicationWillTerminate:(NSNotification *)notification
{
    [self.managedObjectContext SMK_saveChanges];
}

#pragma mark - Sync

- (void)sync
{
    // There's a sync already happening
    if ([_operationQueue operationCount] != 0)
        return;
    
    __block SMKiTunesContentSource *weakSelf = self;
    SMKiTunesSyncOperation *operation = [SMKiTunesSyncOperation new];
    [operation setCompletionBlock:^(SMKiTunesSyncOperation *op, NSUInteger count) {
        SMKiTunesContentSource *strongSelf = weakSelf;
        if (strongSelf->_waiter) {
            dispatch_semaphore_signal(strongSelf->_waiter);
        }
    }];
    [_operationQueue addOperation:operation];
}

#pragma mark - Core Data Boilerplate

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        NSError *error = [NSError SMK_errorWithCode:SMKCoreDataErrorFailedToInitializeStore description:[NSString stringWithFormat:@"Failed to initialize the store for class: %@", NSStringFromClass([self class])]];
        NSLog(@"Error: %@, %@", error, [error userInfo]);
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    [_managedObjectContext setUndoManager:nil];
    [_managedObjectContext setContentSource:self];
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"SMKiTunesDataModel" withExtension:@"momd"];
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
            [[NSApplication sharedApplication] presentError:error];
            return nil;
        }
    } else {
        if (![properties[NSURLIsDirectoryKey] boolValue]) {
            NSString *failureDescription = [NSString stringWithFormat:@"Expected a folder to store application data, found a file (%@).", [applicationFilesDirectory path]];
            error = [NSError SMK_errorWithCode:SMKCoreDataErrorDataStoreNotAFolder description:failureDescription];
            NSLog(@"Error: %@, %@", error, [error userInfo]);
            return nil;
        }
    }
    
    NSURL *url = [applicationFilesDirectory URLByAppendingPathComponent:@"SMKiTunesContentSource.storedata"];
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    if (![coordinator addPersistentStoreWithType:NSXMLStoreType configuration:nil URL:url options:nil error:&error]) {
        [[NSApplication sharedApplication] presentError:error];
        return nil;
    }
    _persistentStoreCoordinator = coordinator;
    
    return _persistentStoreCoordinator;
}
@end
