//
//  SMKiTunesContentSource.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-21.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMKManagedObjectContext.h"
#import "SMKContentSource.h"
#import "SMKiTunesConstants.h"
#import "SMKiTunesPlaylist.h"
#import "SMKiTunesTrack.h"
#import "SMKiTunesArtist.h"
#import "SMKiTunesAlbum.h"
#import "SMKiTunesObject.h"

@interface SMKiTunesContentSource : NSObject <SMKContentSource>

#pragma mark - Content Source Specific API

/** 
 Access to Core Data backing store 
 */
@property (nonatomic, strong) SMKManagedObjectContext *mainQueueObjectContext;
@property (nonatomic, strong) SMKManagedObjectContext *backgroundQueueObjectContext;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;

/** 
 Set to NO if you don't want to sync playlists
 */
@property (nonatomic, assign) BOOL syncPlaylists;

/** 
 Starts a sync with iTunes. This method is called automatically in SMKiTunesContentSource's -init. 
 @discussion This method starts an asynchronous operation and will return immediately
 */
- (void)sync;

/** 
 Deletes the persistent store used to cache the iTunes Library info.
 @discussion You must manually call -sync again before accessing anything
 */
- (void)deleteStore;

#pragma mark - Fetching

/**
 Executes the specified fetch request synchronously
 @param request The fetch request to execute
 @parame error An NSError providing error information if the request fails
 */
- (NSArray *)executeFetchRequestSynchronously:(NSFetchRequest *)request
                                        error:(NSError **)error;

/**
 Executes the specified fetch request asynchronously
 @param request The fetch request to execute
 @parame handler Completion handler to be called upon execution of the request
 */
- (void)executeFetchRequestAsynchronously:(NSFetchRequest *)request
                        completionHandler:(void(^)(NSArray *playlists, NSError *error))handler;
@end
