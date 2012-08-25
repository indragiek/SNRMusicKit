//
//  SPAlbum+SMKAlbum.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-24.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SPAlbum+SMKAlbum.h"
#import "NSObject+SMKSpotifyAdditions.h"
#import "SMKSpotifyConstants.h"
#import "NSObject+AssociatedObjects.h"

static void* const SMKSPAlbumBrowseKey = @"SMK_SPAlbumBrowse";

@implementation SPAlbum (SMKAlbum)

#pragma mark - SMKAlbum

- (NSArray *)tracksWithSortDescriptors:(NSArray *)sortDescriptors
                             predicate:(NSPredicate *)predicate
                             batchSize:(NSUInteger)batchSize
                            fetchLimit:(NSUInteger)fetchLimit
                                 error:(NSError **)error
{
    SPAlbumBrowse *browse = [self _associatedAlbumBrowse];
    [browse SMK_spotifyWaitUntilLoaded];
    *error = browse.loadError;
    return [self _tracksFromBrowse:browse
                   sortDescriptors:sortDescriptors
                         predicate:predicate
                        fetchLimit:fetchLimit];
}

- (void)fetchTracksWithSortDescriptors:(NSArray *)sortDescriptors
                             predicate:(NSPredicate *)predicate
                             batchSize:(NSUInteger)batchSize
                            fetchLimit:(NSUInteger)fetchLimit
                     completionHandler:(void(^)(NSArray *tracks, NSError *error))handler
{
    SPAlbumBrowse *browse = [self _associatedAlbumBrowse];
    __weak SPAlbum *weakSelf = self;
    [SPAsyncLoading waitUntilLoaded:browse timeout:SMKSpotifyDefaultLoadingTimeout then:^(NSArray *loadedItems, NSArray *notLoadedItems) {
        SPAlbum *strongSelf = weakSelf;
        if(handler)
            handler([strongSelf _tracksFromBrowse:browse
                              sortDescriptors:sortDescriptors
                                    predicate:predicate
                                   fetchLimit:fetchLimit], browse.loadError);
    }];
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
    [self SMK_spotifyWaitUntilLoaded];
    SPImage *image = [self _imageForSize:size];
    [image SMK_spotifyWaitUntilLoaded];
    return image.image;
}

- (void)fetchArtworkWithSize:(SMKArtworkSize)size
       withCompletionHandler:(void(^)(SMKPlatformNativeImage *image, NSError *error))handler
{
    __weak SPAlbum *weakSelf = self;
    [SPAsyncLoading waitUntilLoaded:self timeout:SMKSpotifyDefaultLoadingTimeout then:^(NSArray *loadedItems, NSArray *notLoadedItems) {
        SPAlbum *strongSelf = weakSelf;
        SPImage *image = [strongSelf _imageForSize:size];
        [SPAsyncLoading waitUntilLoaded:image timeout:SMKSpotifyDefaultLoadingTimeout then:^(NSArray *loadedItems, NSArray *notLoadedItems) {
            if (handler)
                handler(image.image, nil);
        }];
    }];
}

#pragma mark - Private

- (NSArray *)_tracksFromBrowse:(SPAlbumBrowse *)browse
          sortDescriptors:(NSArray *)sortDescriptors
                predicate:(NSPredicate *)predicate
               fetchLimit:(NSUInteger)limit
{
    NSMutableArray *tracks = [NSMutableArray arrayWithArray:browse.tracks];
    if (predicate)
        [tracks filterUsingPredicate:predicate];
    if (sortDescriptors)
        [tracks sortUsingDescriptors:sortDescriptors];
    if (limit > [tracks count])
        [tracks removeObjectsInRange:NSMakeRange(limit, [tracks count] - limit)];
    return tracks;
}

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

- (SPAlbumBrowse *)_associatedAlbumBrowse
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
