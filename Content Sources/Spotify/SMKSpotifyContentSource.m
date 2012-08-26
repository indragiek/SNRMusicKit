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

@implementation SMKSpotifyContentSource {
    dispatch_queue_t _localQueue;
}
#pragma mark - SMKContentSource

- (NSString *)name { return @"Spotify"; }
+ (BOOL)supportsBatching { return NO; }
+ (Class)defaultPlayerClass { return [SMKSpotifyPlayer class]; }

- (NSArray *)playlistsWithSortDescriptors:(NSArray *)sortDescriptors
                                batchSize:(NSUInteger)batchSize
                               fetchLimit:(NSUInteger)fetchLimit
                                predicate:(NSPredicate *)predicate
                                withError:(NSError **)error
{
    [self SMK_spotifyWaitUntilLoaded];
    [self.starredPlaylist SMK_spotifyWaitUntilLoaded];
    [self.inboxPlaylist SMK_spotifyWaitUntilLoaded];
    [self.userPlaylists SMK_spotifyWaitUntilLoaded];
    return [self _allPlaylistsWithSortDescriptors:sortDescriptors
                                                 fetchLimit:fetchLimit
                                                  predicate:predicate];
    
}

- (void)fetchPlaylistsWithSortDescriptors:(NSArray *)sortDescriptors
                                batchSize:(NSUInteger)batchSize
                               fetchLimit:(NSUInteger)fetchLimit
                                predicate:(NSPredicate *)predicate
                        completionHandler:(void(^)(NSArray *playlists, NSError *error))handler
{
    __weak SMKSpotifyContentSource *weakSelf = self;
    [self SMK_spotifyWaitAsyncThen:^{
        SMKSpotifyContentSource *strongSelf = weakSelf;
        dispatch_async(strongSelf.spotifyLocalQueue, ^{
            dispatch_group_t group = dispatch_group_create();
            [strongSelf.starredPlaylist SMK_spotifyWaitAsyncThen:nil group:group];
            [strongSelf.inboxPlaylist SMK_spotifyWaitAsyncThen:nil group:group];
            [strongSelf.userPlaylists SMK_spotifyWaitAsyncThen:^{
                [strongSelf.userPlaylists.playlists enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    [obj SMK_spotifyWaitAsyncThen:nil group:group];
                }];
            } group:group];
            dispatch_group_notify(group, strongSelf.spotifyLocalQueue, ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (handler)
                        handler([strongSelf _allPlaylistsWithSortDescriptors:sortDescriptors
                                                                  fetchLimit:fetchLimit
                                                                   predicate:predicate], nil);
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

#pragma mark - Private

- (NSArray *)_allPlaylistsWithSortDescriptors:(NSArray *)sortDescriptors fetchLimit:(NSUInteger)fetchLimit predicate:(NSPredicate *)predicate
{
    NSMutableArray *playlists = [NSMutableArray arrayWithObjects:self.inboxPlaylist, self.starredPlaylist, nil];
    [playlists addObjectsFromArray:[self.userPlaylists flattenedPlaylists]];
    [playlists SMK_processWithSortDescriptors:sortDescriptors
                                    predicate:predicate
                                   fetchLimit:fetchLimit];
    return playlists;
}
@end
