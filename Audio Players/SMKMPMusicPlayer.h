//
//  SMKMPMusicPlayer.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-28.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "SMKPlayer.h"

/**
 SMKMPMusicPlayer is a wrapper for MPMusicPlayerController. It's implemented because
 AVQueuePlayer doesn't support iTunes Match streaming/downloading. 
 
 SMKMPMediaTrack will automatically use this player when it's a track on the cloud
 */
@interface SMKMPMusicPlayer : NSObject <SMKPlayer>

@property (nonatomic, copy) void (^finishedTrackBlock)(id<SMKPlayer> player, id<SMKTrack> track, NSError *error);
@property (nonatomic, strong, readonly) MPMusicPlayerController *audioPlayer;

@property (nonatomic, assign) NSTimeInterval seekTimeInterval;
@property (nonatomic, assign, readonly) NSTimeInterval playbackTime;
@property (nonatomic, assign, readonly) BOOL playing;
@property (nonatomic, strong, readonly) id<SMKTrack> currentTrack;

- (void)pause;
- (void)play;
@end
