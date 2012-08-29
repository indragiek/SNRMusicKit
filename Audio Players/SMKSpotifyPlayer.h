//
//  SMKSpotifyPlayer.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-25.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#if TARGET_OS_IPHONE
#import "CocoaLibSpotify.h"
#else
#import <CocoaLibSpotify/CocoaLibSpotify.h>
#endif

#import "SMKPlayer.h"

@interface SMKSpotifyPlayer : NSObject <SMKPlayer>

#pragma mark - SMKPlayer
@property (nonatomic, copy) void (^finishedTrackBlock)(id<SMKPlayer> player, id<SMKTrack> track, NSError *error);
@property (nonatomic, strong, readonly) SPPlaybackManager *audioPlayer;

@property (nonatomic, assign) NSTimeInterval seekTimeInterval;
@property (nonatomic, assign, readonly) NSTimeInterval playbackTime;
@property (nonatomic, assign, readonly) BOOL playing;
@property (nonatomic, assign) float volume;
@property (nonatomic, strong, readonly) id<SMKTrack> currentTrack;

- (id)initWithPlaybackSession:(SPSession *)aSession;

// Seeking (SMKPlayer @optional)
- (void)seekToPlaybackTime:(NSTimeInterval)time;
- (void)seekBackward;
- (void)seekForward;

// Preloading (SMKPlayer @optional)
@property (nonatomic, strong, readonly) id<SMKTrack> preloadedTrack;
- (void)preloadTrack:(id<SMKTrack>)track completionHandler:(void(^)(NSError *error))handler;
- (id<SMKTrack>)preloadedTrack;
- (void)skipToPreloadedTrack;
@end
