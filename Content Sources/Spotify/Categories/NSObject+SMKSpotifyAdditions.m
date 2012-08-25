//
//  NSObject+SMKSpotifyAdditions.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-24.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "NSObject+SMKSpotifyAdditions.h"
#import "NSObject+SMKAdditions.h"
#import <CocoaLibSpotify/CocoaLibSpotify.h>

@implementation NSObject (SMKSpotifyAdditions)
- (void)SMK_spotifyWaitUntilLoaded
{
    if ([self conformsToProtocol:@protocol(SPAsyncLoading)]) {
        id<SPAsyncLoading> asyncObject = (id)self;
        if ([asyncObject isLoaded]) { return; }
        __weak id weakSelf = self;
        [SPAsyncLoading waitUntilLoaded:self timeout:SMKSpotifyDefaultLoadingTimeout then:^(NSArray *loadedItems, NSArray *notLoadedItems) {
            id strongSelf = weakSelf;
            [strongSelf SMK_semaphoreSignal];
        }];
        [self SMK_semaphoreWait:DISPATCH_TIME_FOREVER];
    }
}

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
