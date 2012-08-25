//
//  SMKSpotifyContentSource.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-24.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SMKSpotifyContentSource.h"
#import "NSObject+SMKSpotifyAdditions.h"
#import "NSMutableArray+SMKAdditions.h"
#import "SMKSpotifyConstants.h"

@implementation SMKSpotifyContentSource {
    dispatch_queue_t _localQueue;
}
#pragma mark - SMKContentSource

- (NSString *)name { return @"Spotify"; }
+ (BOOL)supportsBatching { return NO; }

- (NSArray *)playlistsWithSortDescriptors:(NSArray *)sortDescriptors
                                batchSize:(NSUInteger)batchSize
                               fetchLimit:(NSUInteger)fetchLimit
                                predicate:(NSPredicate *)predicate
                                withError:(NSError **)error
{
    [self SMK_spotifyWaitUntilLoaded];
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
    [SPAsyncLoading waitUntilLoaded:self timeout:SMKSpotifyDefaultLoadingTimeout then:^(NSArray *loadedItems, NSArray *notLoadedItems) {
        dispatch_async(self.spotifyLocalQueue, ^{
            NSArray *sorted = [self _allPlaylistsWithSortDescriptors:sortDescriptors
                                                          fetchLimit:fetchLimit
                                                           predicate:predicate];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (handler)
                    handler(sorted, nil);
            });
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
    [playlists SMK_processWithSortDescriptors:sortDescriptors predicate:predicate fetchLimit:fetchLimit];
    return playlists;
}
@end
