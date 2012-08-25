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

- (NSArray *)tracksWithSortDescriptors:(NSArray *)sortDescriptors
                             predicate:(NSPredicate *)predicate
                             batchSize:(NSUInteger)batchSize
                            fetchLimit:(NSUInteger)fetchLimit
                                 error:(NSError **)error
{
    SPAlbumBrowse *browse = [self SMK_associatedAlbumBrowse];
    NSArray *objects = [SMKSpotifyHelpers loadItemsSynchronously:@[browse]
                                                 sortDescriptors:sortDescriptors
                                                       predicate:predicate
                                                      fetchLimit:fetchLimit];
    *error = browse.loadError;
    return objects;
}

- (void)fetchTracksWithSortDescriptors:(NSArray *)sortDescriptors
                             predicate:(NSPredicate *)predicate
                             batchSize:(NSUInteger)batchSize
                            fetchLimit:(NSUInteger)fetchLimit
                     completionHandler:(void(^)(NSArray *tracks, NSError *error))handler
{
    SPAlbumBrowse *browse = [self SMK_associatedAlbumBrowse];
    dispatch_queue_t queue = [(SMKSpotifyContentSource *)self.session spotifyLocalQueue];
    [SMKSpotifyHelpers loadItemsAynchronously:@[browse]
                              sortDescriptors:sortDescriptors
                                    predicate:predicate
                                   fetchLimit:fetchLimit
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

- (SMKPlatformNativeImage *)artworkWithSize:(SMKArtworkSize)size error:(NSError **)error
{
    SPImage *image = [self _imageForSize:size];
    [image SMK_spotifyWaitUntilLoaded];
    return image.image;
}

- (void)fetchArtworkWithSize:(SMKArtworkSize)size
       withCompletionHandler:(void(^)(SMKPlatformNativeImage *image, NSError *error))handler
{
    SPImage *image = [self _imageForSize:size];
    [image SMK_spotifyWaitAsyncThen:^{
        if (handler) { handler(image.image, nil); }
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
