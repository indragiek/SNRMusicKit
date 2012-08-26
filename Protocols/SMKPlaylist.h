//
//  SMKPlaylist.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-21.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMKTrack.h"
#import "SMKContentSource.h"
#import "SMKUser.h"

#import "SMKContentObject.h"

@protocol SMKPlaylist <NSObject, SMKContentObject>
@required

/**
  This method will fetch the tracks asynchronously and call the completion handler when finished.
 @param handler Handler to call when tracks have been fetched
 */
- (void)fetchTracksWithCompletionHandler:(void(^)(NSArray *tracks, NSError *error))handler;

/**
 @return Whether the playlist is editable
 */
- (BOOL)isEditable;

@optional

/**
 @return The user this playlist belongs to
 */
- (id<SMKUser>)user;

/** 
 @return An optional extended description for the playlist.
 */
- (NSString *)extendedDescription;

/* These are methods for editing that will only be called if -isEditable returns YES.
 All indexes are relative to the state of the playlist before any changes */

/**
 @param indexes The original indexes of the items to move.
 @param index The index to move the items to.
 @param handler A handler block to be called when the operation completes
 */
- (void)moveTracksAtIndexes:(NSIndexSet*)indexes toIndex:(NSUInteger)index completionHandler:(void(^)(NSError *error))handler;

/**
 @param tracks The tracks to move
 @param index The index to move the tracks to.
 @param handler A handler block to be called when the operation completes
 */
- (void)moveTracks:(NSArray*)tracks toIndex:(NSUInteger)index completionHandler:(void(^)(NSError *error))handler;

/**
 @param track The tracks to add to the playlist.
 @param index The index to add the tracks to.
 @param handler A handler block to be called when the operation completes
 */
- (void)addTracks:(NSArray*)tracks atIndex:(NSUInteger)index completionHandler:(void(^)(NSError *error))handler;

/**
 @param indexes The indexes of the tracks to remove
 @param handler A handler block to be called when the operation completes
 */
- (void)removeTracksAtIndexes:(NSIndexSet *)indexes completionHandler:(void(^)(NSError *error))handler;

@end
