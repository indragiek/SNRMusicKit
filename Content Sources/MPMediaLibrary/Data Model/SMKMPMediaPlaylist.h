//
//  SMKMPMediaPlaylist.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-27.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "SMKPlaylist.h"

@interface SMKMPMediaPlaylist : NSObject <SMKPlaylist>
@property (nonatomic, strong) MPMediaItemCollection *representedObject;
@property (nonatomic, assign, readonly) id<SMKContentSource> contentSource;
@end
