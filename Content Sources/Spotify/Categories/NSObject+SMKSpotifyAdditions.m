//
//  NSObject+SMKSpotifyAdditions.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-24.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "NSObject+SMKSpotifyAdditions.h"

#if TARGET_OS_IPHONE
#import "CocoaLibSpotify.h"
#else
#import <CocoaLibSpotify/CocoaLibSpotify.h>
#endif

@implementation NSObject (SMKSpotifyAdditions)

- (void)SMK_spotifyWaitAsyncThen:(void(^)())then
{
    [self SMK_spotifyWaitAsyncThen:then group:NULL];
}

- (void)SMK_spotifyWaitAsyncThen:(void(^)())then group:(dispatch_group_t)group
{
    if ([self conformsToProtocol:@protocol(SPAsyncLoading)]) {
        if (group) dispatch_group_enter(group);
        [SPAsyncLoading waitUntilLoaded:self timeout:SMKSpotifyDefaultLoadingTimeout then:^(NSArray *loadedItems, NSArray *notLoadedItems) {
            if (group) dispatch_group_leave(group);
            if (then) then();
        }];
    } else if (then) {
        then();
    }
}
@end
