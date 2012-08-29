//
//  SMKAVQueuePlayer.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-23.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "SMKPlayer.h"

/**
 SMKAVQeuuePlayer is a wrapper for AVQueuePlayer
 
 It supports all the formats that OS X itself supports, including MP3, MPEG-4,
 AIFF, WAVE, and AAC as well as HTTP streaming of audio.
 */
@interface SMKAVQueuePlayer : NSObject <SMKPlayer>

#pragma mark - SMKPlayer API
@property (nonatomic, copy) void (^finishedTrackBlock)(id<SMKPlayer> player, id<SMKTrack> track, NSError *error);
@property (nonatomic, strong, readonly) AVQueuePlayer *audioPlayer;

@property (nonatomic, assign) NSTimeInterval seekTimeInterval;
@property (nonatomic, assign, readonly) NSTimeInterval playbackTime;
@property (nonatomic, assign, readonly) BOOL playing;
@property (nonatomic, strong, readonly) id<SMKTrack> currentTrack;

#if !TARGET_OS_IPHONE
@property (nonatomic, assign) float volume;
#endif

- (void)pause;
- (void)play;

// Preloading (SMKPlayer @optional)
@property (nonatomic, strong, readonly) id<SMKTrack> preloadedTrack;
- (void)preloadTrack:(id<SMKTrack>)track completionHandler:(void(^)(NSError *error))handler;
- (id<SMKTrack>)preloadedTrack;
- (void)skipToPreloadedTrack;
@end
