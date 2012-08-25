//
//  SMKSpotifyPlayer.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-25.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <CocoaLibSpotify/CocoaLibSpotify.h>
#import "SMKPlayer.h"

@interface SMKSpotifyPlayer : SPPlaybackManager <SMKPlayer>

#pragma mark - SMKPlayer
@property (nonatomic, copy) void (^finishedTrackBlock)(id<SMKPlayer> player, id<SMKTrack> track, NSError *error);
@property (nonatomic, assign) NSTimeInterval seekTimeInterval;
@property (nonatomic, assign, readonly) NSTimeInterval playbackTime;
@property (nonatomic, assign, readonly) BOOL playing;
@end
