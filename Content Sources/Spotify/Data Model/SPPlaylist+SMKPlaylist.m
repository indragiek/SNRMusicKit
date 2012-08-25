//
//  SPPlaylist+SMKPlaylist.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-24.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SPPlaylist+SMKPlaylist.h"

#import "SMKSpotifyConstants.h"
#import "SMKSpotifyContentSource.h"

#import "SPUser+SMKUser.h"
#import "NSObject+SMKSpotifyAdditions.h"
#import "NSMutableArray+SMKAdditions.h"
#import "SPAlbum+SMKAlbum.h"
#import "SPArtist+SMKArtist.h"

@interface SPPlaylist (SMKInternal)
@property (nonatomic, readwrite, assign) __unsafe_unretained SPSession *session;
@end

@interface SMKSpotifyContentSource (SMKInternal)
- (dispatch_queue_t)_spotifyWaitingQueue;
@end

@implementation SPPlaylist (SMKPlaylist)

#pragma mark - SMKPlaylist

- (NSArray *)tracksWithSortDescriptors:(NSArray *)sortDescriptors
                             predicate:(NSPredicate *)predicate
                             batchSize:(NSUInteger)batchSize
                            fetchLimit:(NSUInteger)fetchLimit
                             withError:(NSError **)error
{
    [self SMK_spotifyWaitUntilLoaded];
    return [self _flattenedTracksWithSortDescriptors:sortDescriptors
                                           predicate:predicate
                                          fetchLimit:fetchLimit];
}

- (void)fetchTracksWithSortDescriptors:(NSArray *)sortDescriptors
                             predicate:(NSPredicate *)predicate
                             batchSize:(NSUInteger)batchSize
                            fetchlimit:(NSUInteger)fetchLimit
                     completionHandler:(void(^)(NSArray *tracks, NSError *error))handler
{
    __weak SPPlaylist *weakSelf = self;
    [SPAsyncLoading waitUntilLoaded:self timeout:kSPAsyncLoadingDefaultTimeout then:^(NSArray *loadedItems, NSArray *notLoadedItems) {
        SPPlaylist *strongSelf = weakSelf;
        [strongSelf _asyncFlattenedTracksWithSortDescriptors:sortDescriptors predicate:predicate fetchLimit:fetchLimit completionHandler:handler];
    }];
}

- (BOOL)isEditable
{
    return YES;
}

- (id<SMKUser>)user
{
    [self SMK_spotifyWaitUntilLoaded];
    return self.owner;
}

- (NSString *)extendedDescription
{
    [self SMK_spotifyWaitUntilLoaded];
    return self.playlistDescription;
}

- (void)moveTracks:(NSArray*)tracks
           toIndex:(NSUInteger)index
 completionHandler:(void(^)(NSError *error))handler
{
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    __weak SPPlaylist *weakSelf = self;
    [tracks enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        SPPlaylist *strongSelf = weakSelf;
        NSUInteger itemsIndex = [strongSelf.items indexOfObject:obj];
        if (itemsIndex != NSNotFound)
            [indexSet addIndex:itemsIndex];
    }];
    [self moveTracksAtIndexes:indexSet toIndex:index completionHandler:handler];
}

#pragma mark - SMKContentObject

- (NSString *)uniqueIdentifier
{
    return [self.spotifyURL absoluteString];
}

+ (NSSet *)supportedSortKeys
{
    return [NSSet setWithObjects:@"name", @"extendedDescription", nil];
}

- (id<SMKContentSource>)contentSource
{
    return (id<SMKContentSource>)self.session;
}

#pragma mark - SMKArtworkObject

- (SMKPlatformNativeImage *)artworkWithSize:(SMKArtworkSize)size error:(NSError **)error
{
    [self SMK_spotifyWaitUntilLoaded];
    [self.image SMK_spotifyWaitUntilLoaded];
    return [self.image image];
}

- (void)fetchArtworkWithSize:(SMKArtworkSize)size
       withCompletionHandler:(void(^)(SMKPlatformNativeImage *image, NSError *error))handler
{
    __weak SPPlaylist *weakSelf = self;
    [SPAsyncLoading waitUntilLoaded:self timeout:SMKSpotifyDefaultLoadingTimeout then:^(NSArray *loadedItems, NSArray *notLoadedItems) {
        SPPlaylist *strongSelf = weakSelf;
       [strongSelf _waitUntilImageLoadedAndCallHandler:handler];
    }];
}

#pragma mark - SMKWebObject

- (NSURL *)webURL
{
    return self.spotifyURL;
}

#pragma mark - Private

- (void)_waitUntilImageLoadedAndCallHandler:(void(^)(SMKPlatformNativeImage *image, NSError *error))handler
{
     __weak SPPlaylist *weakSelf = self;
    [SPAsyncLoading waitUntilLoaded:self.image timeout:SMKSpotifyDefaultLoadingTimeout then:^(NSArray *loadedItems, NSArray *notLoadedItems) {
        SPPlaylist *strongSelf = weakSelf;
        if (handler)
            handler(strongSelf.image.image, nil);
    }];
}

- (NSArray *)_flattenedTracksWithSortDescriptors:(NSArray *)sortDescriptors
                                       predicate:(NSPredicate *)predicate
                                      fetchLimit:(NSUInteger)fetchLimit
{
    NSMutableArray *tracks = [NSMutableArray array];
    [self.items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id item = [(SPPlaylistItem *)obj item];
        if ([item isKindOfClass:[SPTrack class]]) {
            [tracks addObject:item];
        } else if ([item isKindOfClass:[SPAlbum class]]) {
            [tracks addObjectsFromArray:[(SPAlbum *)item tracksWithSortDescriptors:nil predicate:nil batchSize:0 fetchLimit:0 error:nil]];
        } else if ([item isKindOfClass:[SPArtist class]]) {
            NSArray *albums = [(SPArtist *)item albumsWithSortDescriptors:nil predicate:nil batchSize:0 fetchLimit:0 error:nil];
            [albums enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [tracks addObjectsFromArray:[(SPAlbum *)obj tracksWithSortDescriptors:nil predicate:nil batchSize:0 fetchLimit:0 error:nil]];
            }];
        } else if ([item isKindOfClass:[SPPlaylist class]]) {
            [tracks addObjectsFromArray:[(SPPlaylist *)item tracksWithSortDescriptors:nil predicate:nil batchSize:0 fetchLimit:0 withError:nil]];
        }
    }];
    [tracks SMK_processWithSortDescriptors:sortDescriptors predicate:predicate fetchLimit:fetchLimit];
    return tracks;
}

- (void)_asyncFlattenedTracksWithSortDescriptors:(NSArray *)sortDescriptors
                                       predicate:(NSPredicate *)predicate
                                      fetchLimit:(NSUInteger)fetchLimit
                               completionHandler:(void(^)(NSArray *tracks, NSError *error))handler
{
    __weak SPPlaylist *weakSelf = self;
    dispatch_queue_t waitingQueue = [(SMKSpotifyContentSource *)self.session _spotifyWaitingQueue];
    dispatch_async(waitingQueue, ^{
        dispatch_group_t group = dispatch_group_create();
        NSMutableArray *playlistTracks = [NSMutableArray array];
        dispatch_sync(dispatch_get_main_queue(), ^{
            SPPlaylist *strongSelf = weakSelf;
            [strongSelf.items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                id item = [(SPPlaylistItem *)obj item];
                if ([item isKindOfClass:[SPTrack class]]) {
                    [playlistTracks addObject:item];
                } else if ([item isKindOfClass:[SPAlbum class]]) {
                    dispatch_group_enter(group);
                    [(SPAlbum *)item fetchTracksWithSortDescriptors:nil predicate:nil batchSize:0 fetchLimit:0 completionHandler:^(NSArray *tracks, NSError *error) {
                        [playlistTracks addObjectsFromArray:tracks];
                        dispatch_group_leave(group);
                    }];
                } else if ([item isKindOfClass:[SPArtist class]]) {
                    dispatch_group_enter(group);
                    [(SPArtist *)item fetchAlbumsWithSortDescriptors:nil predicate:nil batchSize:0 fetchLimit:0 completionHandler:^(NSArray *albums, NSError *error) {
                        [albums enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                            dispatch_group_enter(group);
                            [(SPAlbum *)obj fetchTracksWithSortDescriptors:nil predicate:nil batchSize:0 fetchLimit:0 completionHandler:^(NSArray *tracks, NSError *error) {
                                [playlistTracks addObjectsFromArray:tracks];
                                dispatch_group_leave(group);
                            }];
                        }];
                        dispatch_group_leave(group);
                    }];
                } else if ([item isKindOfClass:[SPPlaylist class]]) {
                    dispatch_group_enter(group);
                    [(SPPlaylist *)item fetchTracksWithSortDescriptors:nil predicate:nil batchSize:0 fetchlimit:0 completionHandler:^(NSArray *tracks, NSError *error) {
                        [playlistTracks addObjectsFromArray:tracks];
                        dispatch_group_leave(group);
                    }];
                }
            }];
        });
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        dispatch_release(group);
        [playlistTracks SMK_processWithSortDescriptors:sortDescriptors predicate:predicate fetchLimit:fetchLimit];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (handler)
                handler(playlistTracks, nil);
        });
    });
}
@end
