//
//  SMKSFBAudioPlayer.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-21.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMKPlayer.h"

@interface SMKSFBAudioPlayer : NSObject <SMKPlayer>

#pragma mark - SMKPlayer API

@property (nonatomic, assign) id<SMKPlayerDelegate> delegate;
@property (nonatomic, assign) float volume;
@property (nonatomic, assign) NSTimeInterval seekTimeInterval;

#pragma mark - Player Specific API
@property (nonatomic, assign) float preGain;

/** 
 @param value The EQ band value in dB
 @param band The band number from 0-9 (10 band equalizer)
 */
- (void)setEQValue:(float)value forEQBand:(int)band;

/** Set this to YES to load the entire file in memory before playing instead of using a buffer */
@property (nonatomic, assign) BOOL loadFilesInMemory;
@end
