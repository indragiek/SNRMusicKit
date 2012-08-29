//
//  SMKSFBAudioPlayer.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-21.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMKPlayer.h"


/**
 SMKSFBAudioPlayer is a wrapper class around SFBAudioEngine that provides support for a multitude of audio formats.
 
 Supported formats include: MP3, MPEG-4, AIFF, WAV, OGG, FLAC, Musepack, WavPack, 
 Monkey's Audio, MOD, S3M, XM, IT, True Audio
 */
@interface SMKSFBAudioPlayer : NSObject <SMKPlayer>

#pragma mark - SMKPlayer API

@property (nonatomic, copy) void (^finishedTrackBlock)(id<SMKPlayer> player, id<SMKTrack> track, NSError *error);
@property (nonatomic, assign) float volume;
@property (nonatomic, assign) NSTimeInterval seekTimeInterval;
@property (nonatomic, assign, readonly) NSTimeInterval playbackTime;
@property (nonatomic, assign, readonly) BOOL playing;
@property (nonatomic, strong, readonly) id<SMKTrack> currentTrack;

// Preloading (SMKPlayer @optional)
@property (nonatomic, strong, readonly) id<SMKTrack> preloadedTrack;
- (void)preloadTrack:(id<SMKTrack>)track completionHandler:(void(^)(NSError *error))handler;
- (id<SMKTrack>)preloadedTrack;
- (void)skipToPreloadedTrack;

#pragma mark - Player Specific API

@property (nonatomic, assign) float preGain;

/** 
 @param value The EQ band value in dB
 @param band The band number from 0-9 (10 band equalizer)
 */
- (void)setEQValue:(float)value forEQBand:(int)band;

/** 
 Set this to YES to load the entire file in memory before playing instead of using a buffer 
 */
@property (nonatomic, assign) BOOL loadFilesInMemory;
@end
