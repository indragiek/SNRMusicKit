//
//  NSObject+SMKSpotifyAdditions.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-24.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMKSpotifyConstants.h"

@interface NSObject (SMKSpotifyAdditions)
- (void)SMK_spotifyWaitUntilLoaded;
- (void)SMK_spotifyWaitAsyncThen:(void(^)())then;
@end
