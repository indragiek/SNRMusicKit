//
//  SMKiTunesContentSource.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-21.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMKContentSource.h"
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
@property (nonatomic, strong) NSManagedObjectContext *mainQueueObjectContext;
@property (nonatomic, strong) NSManagedObjectContext *backgroundQueueObjectContext;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;

/** 
 Set to NO if you don't want to sync playlists
 */
@property (nonatomic, assign) BOOL syncPlaylists;

/** 
 Starts a sync with iTunes. This method is called automatically in SMKiTunesContentSource's -init. 
 */
- (void)sync;

/** 
 Deletes the persistent store used to cache the iTunes Library info.
 @discussion You must manually call -sync again before accessing anything
 */
- (void)deleteStore;
@end
