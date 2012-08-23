//
//  SMKAVPlayerItem.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-23.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "SMKTrack.h"

/**
 Subclass of AVPlayerItem that supports attaching an SMKTrack to it
 */
@interface SMKAVPlayerItem : AVPlayerItem
@property (nonatomic, strong) id<SMKTrack> SMK_track;
@end
