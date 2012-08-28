//
//  SMKPlayer.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-21.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMKTrack.h"

@protocol SMKPlayerDelegate;
@protocol SMKPlayer <NSObject>
/**
 @return An set of class names containing the names of content sources that this player can play.
 */
+ (NSSet *)supportedContentSourceClasses;

/**
 @return Whether the player supports preloading tracks.
 */
+ (BOOL)supportsPreloading;

/**
 @return Whether the play supports streaming via AirPlay.
 */
+ (BOOL)supportsAirPlay;

/**
 @return Whether the player supports seeking.
 */
- (BOOL)supportsSeeking;

/**
 @return The currently playing track.
 */
- (id<SMKTrack>)currentTrack;

/**
 Play the specified track.
 @param track The track to play.
 @param handler Completion handler called with an NSError if playing failed and nil if successful.
 */
- (void)playTrack:(id<SMKTrack>)track completionHandler:(void(^)(NSError *error))handler;

/**
 Pause playback.
 */
- (void)pause;

/**
 Resume playback.
 */
- (void)play;

/**
 @return Whether the player is playing.
 @discussion This is KVO observable.
 */
- (BOOL)playing;

/**
 @return The current playback time.
 @discussion This is KVO observable.
 */
- (NSTimeInterval)playbackTime;

@optional

/**
 @return The player volume from 0.0 to 1.0
 */
@property (nonatomic, assign) float volume;

/**
 Seek to the specified time if the player supports seeking.
 */
- (void)seekToPlaybackTime:(NSTimeInterval)time;

/**
 Return the seek time interval for the -seekBackward and -seekForward methods.
 */
- (NSTimeInterval)seekTimeInterval;

/**
 Set the seek time interval for the -seekBackward and -seekForward methods.
 @param interval The seek time interval.
 */
- (void)setSeekTimeInterval:(NSTimeInterval)interval;

/**
 Seek backward (-seekTimeInterval) seconds
 */
- (void)seekBackward;

/**
 Seek forward (-seekTimeInterval) seconds
 */
- (void)seekForward;

/**
 Preload the specified track (if the player supports preloading)
 @param handler Completion handler called with an NSError if preloading failed and nil if successful.
 */
- (void)preloadTrack:(id<SMKTrack>)track completionHandler:(void(^)(NSError *error))handler;

/**
 @return The currently preloaded track if there is one
 */
- (id<SMKTrack>)preloadedTrack;

/**
 Skips to the track that the player has preloaded.
 */
- (void)skipToPreloadedTrack;

/**
 @return Whether AirPlay is enabled (assuming the player supports it)
 */
@property (nonatomic, assign) BOOL airPlayEnabled;

/**
 A block called when the current track finishes playing
 */
@property (nonatomic, copy) void (^finishedTrackBlock)(id<SMKPlayer> player, id<SMKTrack> track, NSError *error);
@end