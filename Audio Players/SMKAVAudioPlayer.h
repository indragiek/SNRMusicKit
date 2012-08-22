//
//  SMKAVAudioPlayer.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-21.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMKPlayer.h"

@interface SMKAVAudioPlayer : NSObject <SMKPlayer>

#pragma mark - SMKPlayer API

@property (nonatomic, assign) id<SMKPlayerDelegate> delegate;
@property (nonatomic, assign) float volume;
@property (nonatomic, assign) NSTimeInterval seekTimeInterval;

@end
