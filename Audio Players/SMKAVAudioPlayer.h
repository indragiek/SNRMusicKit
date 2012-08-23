//
//  SMKAVAudioPlayer.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-21.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMKPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface SMKAVAudioPlayer : NSObject <SMKPlayer, AVAudioPlayerDelegate>

#pragma mark - SMKPlayer API

@property (nonatomic, assign) id<SMKPlayerDelegate> delegate;
@property (nonatomic, assign) float volume;
@property (nonatomic, assign) NSTimeInterval seekTimeInterval;
@property (nonatomic, assign, readonly) NSTimeInterval playbackTime;
@property (nonatomic, assign, readonly) BOOL playing;

#pragma mark - Player Specific API
@property (nonatomic, strong, readonly) AVAudioPlayer *audioPlayer;

/**
 Set this to YES to load the entire file in memory before playing instead of using a buffer
 */
@property (nonatomic, assign) BOOL loadFilesInMemory;
@end
