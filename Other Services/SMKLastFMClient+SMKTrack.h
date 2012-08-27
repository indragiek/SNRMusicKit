//
//  SMKLastFMClient+SMKTrack.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-26.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SMKLastFMClient.h"
#import "SMKTrack.h"

@interface SMKLastFMClient (SMKTrack)
/**
 Scrobbles the specified track with Last.fm.
 @param track The track to scrobble
 @param handler Completion handler to be called when operation is complete
 */
- (void)scrobbleTrack:(id<SMKTrack>)track completionHandler:(void (^)(NSDictionary *scrobbles, NSError *error))handler;

/**
 Update's the users now playing status on Last.fm with the specified track
 @param track The track to set as now playing
 @param handler Completion handler to be called when operation is complete
 */
- (void)updateNowPlayingWithTrack:(id<SMKTrack>)track completionHandler:(void (^)(NSDictionary *response, NSError *error))handler;

/**
 Loves the specified track on Last.fm
 @param track The track to love
 @param handler Completion handler to be called when operation is complete
 */
- (void)loveTrack:(id<SMKTrack>)track completionHandler:(void (^)(NSDictionary *response, NSError *error))handler;
@end
