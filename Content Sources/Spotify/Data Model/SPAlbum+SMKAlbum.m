//
//  SPAlbum+SMKAlbum.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-24.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SPAlbum+SMKAlbum.h"
#import "NSObject+SMKSpotifyAdditions.h"
#import "NSObject+AssociatedObjects.h"
#import "NSMutableArray+SMKAdditions.h"

#import "SMKSpotifyConstants.h"
#import "SMKSpotifyContentSource.h"
#import "SMKSpotifyHelpers.h"

static void* const SMKSPAlbumBrowseKey = @"SMK_SPAlbumBrowse";

@implementation SPAlbum (SMKAlbum)

#pragma mark - SMKAlbum

- (void)fetchTracksWithSortDescriptors:(NSArray *)sortDescriptors
                             predicate:(NSPredicate *)predicate
                     completionHandler:(void(^)(NSArray *tracks, NSError *error))handler
{
    SPAlbumBrowse *browse = [self SMK_associatedAlbumBrowse];
    dispatch_queue_t queue = [(SMKSpotifyContentSource *)self.session spotifyLocalQueue];
    [SMKSpotifyHelpers loadItemsAynchronously:@[browse]
                              sortDescriptors:sortDescriptors
                                    predicate:predicate
                                 sortingQueue:queue
                            completionHandler:handler];
}

- (NSUInteger)releaseYear
{
    return self.year;
}

#pragma mark - SMKContentObject

- (NSString *)uniqueIdentifier
{
    return [self.spotifyURL absoluteString];
}

+ (NSSet *)supportedSortKeys
{
    return [NSSet setWithObjects:@"releaseYear", @"name", @"artist", nil];
}

- (id<SMKContentSource>)contentSource
{
    return (id<SMKContentSource>)self.session;
}

#pragma mark - SMKWebObject

- (NSURL *)webURL
{
    return self.spotifyURL;
}

#pragma mark - SMKArtworkObject

- (void)fetchArtworkWithSize:(SMKArtworkSize)size completionHandler:(void(^)(SMKPlatformNativeImage *image, NSError *error))handler
{
    SPImage *image = [self _imageForSize:size];
    [image SMK_spotifyWaitAsyncThen:^{
        if (handler) { handler(image.image, nil); }
    }];
}

#pragma mark - SMKHierarchicalLoading

- (void)loadHierarchy:(dispatch_group_t)group array:(NSMutableArray *)array
{
    dispatch_group_enter(group);
    __weak SPAlbum *weakSelf = self;
    [self SMK_spotifyWaitAsyncThen:^{
        SPAlbum *strongSelf = weakSelf;
        SPAlbumBrowse *browse = [strongSelf SMK_associatedAlbumBrowse];
        [browse loadHierarchy:group array:array];
        dispatch_group_leave(group);
    }];
}

#pragma mark - Private

- (SPImage *)_imageForSize:(SMKArtworkSize)size
{
    switch (size) {
        case SMKArtworkSizeSmallest:
            return self.smallestAvailableCover;
        case SMKArtworkSizeSmall:
            return self.smallCover;
        case SMKArtworkSizeLarge:
            return self.largeCover;
        case SMKArtworkSizeLargest:
            return self.largestAvailableCover;
        default:
            return nil;
            break;
    }
}

- (SPAlbumBrowse *)SMK_associatedAlbumBrowse
{
    __block SPAlbumBrowse *browse = [self associatedValueForKey:SMKSPAlbumBrowseKey];
    if (!browse) {
        dispatch_sync([SPSession libSpotifyQueue], ^{
            browse = [SPAlbumBrowse browseAlbum:self inSession:self.session];
        });
        [self associateValue:browse withKey:SMKSPAlbumBrowseKey];
    }
    return browse;
}
@end

@implementation SPAlbumBrowse (SMKAlbum)

#pragma mark - SMKHierarchicalLoading

- (void)loadHierarchy:(dispatch_group_t)group array:(NSMutableArray *)array
{
    __weak SPAlbumBrowse *weakSelf = self;
    dispatch_group_enter(group);
    [self SMK_spotifyWaitAsyncThen:^{
        SPAlbumBrowse *strongSelf = weakSelf;
        [strongSelf.tracks enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [obj loadHierarchy:group array:array];
        }];
        dispatch_group_leave(group);
    }];
}
@end
