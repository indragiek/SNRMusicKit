//
//  SMKPlayerDelegate.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-21.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMKPlayer.h"

@protocol SMKPlayerDelegate <NSObject>
@optional
- (void)playerWillStartPlaying:(id<SMKPlayer>)player;
- (void)playerDidFinishPlaying:(id<SMKPlayer>)player;
@end
