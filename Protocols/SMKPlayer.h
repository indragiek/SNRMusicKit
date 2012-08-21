//
//  SMKPlayer.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-21.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMKPlayerDelegate.h"
#import "SMKTrack.h"

@protocol SMKPlayer <NSObject>
/**
 @return An array of class names containing the names of content sources that this player can play.
 */
+ (NSArray *)supportedContentSourceClasses;

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
+ (BOOL)supportsSeeking;

/**
 @return The delegate of this player.
 */
- (id<SMKPlayerDelegate>)delegate;

/**
 Set the delegate of the player.
 @param delegate The player delegate.
*/
- (void)setDelegate:(id<SMKPlayerDelegate>)delegate;

/**
 @return The currently playing track.
 */
- (id<SMKTrack>)currentTrack;

/**
 @return The player volume from 0.0 to 1.0
 */
- (float)volume;

/**
 Set the player volume from 0.0 to 1.0
 @param volume The player volume
 */
- (void)setVolume:(float)volume;

/**
 Play the specified track.
 @param track The track to play.
 @param handler Completion handler called with an NSError if playing failed.
 */
- (void)playTrack:(id<SMKTrack>)track completionHandler:(void(^)NSError *error))handler;

/**
 Pause playback.
 */
- (void)pause;

/**
 @return Whether the player is playing.
 */
- (BOOL)isPlaying;

/**
 @return The current playback time.
 */
- (NSTimeInterval)playbackTime;

@optional

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
 @return Whether AirPlay is enabled (assuming the player supports it)
 */
- (BOOL)airPlayEnabled;

/**
 Set whether AirPlay is enabled on the player (if the player supports it).
 @param enabled Whether AirPlay should be enabled
 */
- (void)setAirPlayEnabled:(BOOL)enabled;

/**
 Preload the specified track (if the player supports preloading)
 */
- (void)preloadTrack:(id<SMKTrack>)track;

/**
 @return The currently preloaded track if there is one
 */
- (id<SMKTrack>)preloadedTrack;

/**
 Skips to the track that the player has preloaded.
 */
- (void)skipToPreloadedTrack;
@end
