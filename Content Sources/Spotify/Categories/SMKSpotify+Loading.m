//
//  SMKSpotify+Loading.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-25.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SMKSpotify+Loading.h"
#import "NSObject+SMKSpotifyAdditions.h"
#import "SPAlbum+SMKAlbum.h"
#import "SPArtist+SMKArtist.h"

@implementation SPTrack (Loading)
- (void)SMK_loadHierarchy:(dispatch_group_t)group array:(NSMutableArray *)array
{
    dispatch_group_enter(group);
    [self SMK_spotifyWaitAsyncThen:^{
        [array addObject:self];
        dispatch_group_leave(group);
    }];
}
@end

@implementation SPAlbum (Loading)
- (void)SMK_loadHierarchy:(dispatch_group_t)group array:(NSMutableArray *)array
{
    dispatch_group_enter(group);
    __weak SPAlbum *weakSelf = self;
    [self SMK_spotifyWaitAsyncThen:^{
        SPAlbum *strongSelf = weakSelf;
        SPAlbumBrowse *browse = [strongSelf SMK_associatedAlbumBrowse];
        [browse SMK_loadHierarchy:group array:array];
        dispatch_group_leave(group);
    }];
}
@end

@implementation SPArtist (Loading)
- (void)SMK_loadHierarchy:(dispatch_group_t)group array:(NSMutableArray *)array
{
    dispatch_group_enter(group);
    __weak SPArtist *weakSelf = self;
    [self SMK_spotifyWaitAsyncThen:^{
        SPArtist *strongSelf = weakSelf;
        SPArtistBrowse *browse = [strongSelf SMK_associatedArtistBrowse];
        [browse SMK_loadHierarchy:group array:array];
        dispatch_group_leave(group);
    }];
}
@end

@implementation SPPlaylist (Loading)
- (void)SMK_loadHierarchy:(dispatch_group_t)group array:(NSMutableArray *)array
{
    __weak SPPlaylist *weakSelf = self;
    dispatch_group_enter(group);
    [self SMK_spotifyWaitAsyncThen:^{
        SPPlaylist *strongSelf = weakSelf;
        [strongSelf.items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [obj SMK_loadHierarchy:group array:array];
        }];
        dispatch_group_leave(group);
    }];
}
@end

@implementation SPPlaylistItem (Loading)
- (void)SMK_loadHierarchy:(dispatch_group_t)group array:(NSMutableArray *)array
{
    [(id)self.item SMK_loadHierarchy:group array:array];
}
@end

@implementation SPPlaylistContainer (Loading)
- (void)SMK_loadHierarchy:(dispatch_group_t)group array:(NSMutableArray *)array
{
    __weak SPPlaylistContainer *weakSelf = self;
    dispatch_group_enter(group);
    [self SMK_spotifyWaitAsyncThen:^{
        SPPlaylistContainer *strongSelf = weakSelf;
        [strongSelf.flattenedPlaylists enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [obj SMK_loadHierarchy:group array:array];
        }];
        dispatch_group_leave(group);
    }];
}
@end

@implementation SPAlbumBrowse (Loading)
- (void)SMK_loadHierarchy:(dispatch_group_t)group array:(NSMutableArray *)array
{
    __weak SPAlbumBrowse *weakSelf = self;
    dispatch_group_enter(group);
    [self SMK_spotifyWaitAsyncThen:^{
        SPAlbumBrowse *strongSelf = weakSelf;
        [strongSelf.tracks enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [obj SMK_loadHierarchy:group array:array];
        }];
        dispatch_group_leave(group);
    }];
}
@end

@implementation SPArtistBrowse (Loading)
- (void)SMK_loadHierarchy:(dispatch_group_t)group array:(NSMutableArray *)array
{
    __weak SPArtistBrowse *weakSelf = self;
    dispatch_group_enter(group);
    [self SMK_spotifyWaitAsyncThen:^{
        SPArtistBrowse *strongSelf = weakSelf;
        [strongSelf.albums enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [obj SMK_loadHierarchy:group array:array];
        }];
        dispatch_group_leave(group);
    }];
}
@end