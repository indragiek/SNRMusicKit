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
/**
 Asynchronously waits for the object to finish loading and calls the completion block.
 This method just calls -SMK_spotifyWaitAsyncThen:group: passing NULL as the group
 @param then The block to call when loading is finished.
 */
- (void)SMK_spotifyWaitAsyncThen:(void(^)())then;

/**
 Enters the dispatch group, waits for the object to load, leaves the group, and calls the handler
 @param group The dispatch_group to enter and leave (optional, pass in NULL if you aren't using a group)
 @param then The block to call when loading is finished
 */
- (void)SMK_spotifyWaitAsyncThen:(void(^)())then group:(dispatch_group_t)group;
@end
