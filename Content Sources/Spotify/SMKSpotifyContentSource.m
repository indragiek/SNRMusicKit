//
//  SMKSpotifyContentSource.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-24.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SMKSpotifyContentSource.h"
#import "SMKSpotifyConstants.h"
#import "SMKSpotifyPlayer.h"

#import "NSObject+SMKSpotifyAdditions.h"
#import "NSMutableArray+SMKAdditions.h"
#import "SPToplist+SMKPlaylist.h"

@implementation SMKSpotifyContentSource {
    dispatch_queue_t _localQueue;
}
#pragma mark - SMKContentSource

- (NSString *)name { return @"Spotify"; }

+ (Class)defaultPlayerClass { return [SMKSpotifyPlayer class]; }

+ (Class)predicateClass { return [NSPredicate class]; }

- (void)fetchPlaylistsWithSortDescriptors:(NSArray *)sortDescriptors
                                predicate:(NSPredicate *)predicate
                        completionHandler:(void(^)(NSArray *playlists, NSError *error))handler
{
    __weak SMKSpotifyContentSource *weakSelf = self;
    [self SMK_spotifyWaitAsyncThen:^{
        SMKSpotifyContentSource *strongSelf = weakSelf;
        dispatch_async(strongSelf.spotifyLocalQueue, ^{
            __block SPToplist *globalToplist = nil;
            __block SPToplist *userToplist = nil;
            dispatch_sync([SPSession libSpotifyQueue], ^{
                globalToplist = [SPToplist globalToplistInSession:strongSelf];
                userToplist = [SPToplist toplistForCurrentUserInSession:strongSelf];
            });
            dispatch_group_t group = dispatch_group_create();
            dispatch_group_enter(group);
            [SPAsyncLoading waitUntilLoaded:@[strongSelf.starredPlaylist, strongSelf.inboxPlaylist, strongSelf.userPlaylists, globalToplist, userToplist] timeout:SMKSpotifyDefaultLoadingTimeout then:^(NSArray *loadedItems, NSArray *notLoadedItems) {
                [strongSelf.userPlaylists.playlists enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    [obj SMK_spotifyWaitAsyncThen:nil group:group];
                }];
                dispatch_group_leave(group);
            }];
            dispatch_group_notify(group, strongSelf.spotifyLocalQueue, ^{
                strongSelf.inboxPlaylist.name = @"Inbox";
                strongSelf.starredPlaylist.name = @"Starred";
                globalToplist.name = @"Global Toplist";
                userToplist.name = @"My Toplist";
                NSMutableArray *playlists = [NSMutableArray arrayWithObjects:strongSelf.inboxPlaylist, strongSelf.starredPlaylist, globalToplist, userToplist, nil];
                [playlists addObjectsFromArray:[strongSelf.userPlaylists flattenedPlaylists]];
                [playlists SMK_processWithSortDescriptors:sortDescriptors
                                                predicate:predicate];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (handler)
                        handler(playlists, nil);
                });
            });
            dispatch_release(group);
        });
    }];
}

- (void)dealloc
{
    if (_localQueue)
        dispatch_release(_localQueue);
}

#pragma mark - Accessors

- (dispatch_queue_t)spotifyLocalQueue
{
    if (!_localQueue) {
        _localQueue = dispatch_queue_create("com.indragie.SNRMusicKit.spotifyLocalQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _localQueue;
}
@end
