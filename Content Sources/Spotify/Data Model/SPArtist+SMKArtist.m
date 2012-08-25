//
//  SPArtist+SMKArtist.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-24.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SPArtist+SMKArtist.h"
#import "NSObject+AssociatedObjects.h"
#import "NSObject+SMKSpotifyAdditions.h"
#import "NSMutableArray+SMKAdditions.h"
#import "SMKSpotifyContentSource.h"

static void* const SMKSPArtistBrowseKey = @"SMK_SPArtistBrowse";

@interface SPArtist (SMKInternal)
@property (nonatomic, readwrite, strong) SPSession *session;
@end

@implementation SPArtist (SMKArtist)

#pragma mark - SMKArtist

- (NSArray *)albumsWithSortDescriptors:(NSArray *)sortDescriptors
                             predicate:(NSPredicate *)predicate
                             batchSize:(NSUInteger)batchSize
                            fetchLimit:(NSUInteger)fetchLimit
                                 error:(NSError **)error
{
    SPArtistBrowse *browse = [self _associatedArtistBrowse];
    [browse SMK_spotifyWaitUntilLoaded];
    *error = browse.loadError;
    return [self _albumsFromBrowse:browse
                   sortDescriptors:sortDescriptors
                         predicate:predicate
                        fetchLimit:fetchLimit];
}

- (void)fetchAlbumsWithSortDescriptors:(NSArray *)sortDescriptors
                             predicate:(NSPredicate *)predicate
                             batchSize:(NSUInteger)batchSize
                            fetchLimit:(NSUInteger)fetchLimit
                     completionHandler:(void(^)(NSArray *albums, NSError *error))handler
{
    SPArtistBrowse *browse = [self _associatedArtistBrowse];
    __weak SPArtist *weakSelf = self;
    [SPAsyncLoading waitUntilLoaded:browse timeout:SMKSpotifyDefaultLoadingTimeout then:^(NSArray *loadedItems, NSArray *notLoadedItems) {
        SPArtist *strongSelf = weakSelf;
        SMKSpotifyContentSource *source = (SMKSpotifyContentSource *)self.session;
        dispatch_async(source.spotifyLocalQueue, ^{
            NSArray *sorted = [strongSelf _albumsFromBrowse:browse
                                            sortDescriptors:sortDescriptors
                                                  predicate:predicate
                                                 fetchLimit:fetchLimit];
            dispatch_async(dispatch_get_main_queue(), ^{
                if(handler)
                    handler(sorted, browse.loadError);
            });
        });
    }];
}

#pragma mark - SMKContentObject

- (NSString *)uniqueIdentifier
{
    return [self.spotifyURL absoluteString];
}

+ (NSSet *)supportedSortKeys
{
    return [NSSet setWithObjects:@"name", nil];
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
    SPArtistBrowse *browse = [self _associatedArtistBrowse];
    [browse SMK_spotifyWaitUntilLoaded];
    [browse.firstPortrait SMK_spotifyWaitUntilLoaded];
    return browse.firstPortrait.image;
}

- (void)fetchArtworkWithSize:(SMKArtworkSize)size
       withCompletionHandler:(void(^)(SMKPlatformNativeImage *image, NSError *error))handler
{
    __weak SPArtist *weakSelf = self;
    [SPAsyncLoading waitUntilLoaded:self timeout:SMKSpotifyDefaultLoadingTimeout then:^(NSArray *loadedItems, NSArray *notLoadedItems) {
        SPArtist *strongSelf = weakSelf;
        SPArtistBrowse *browse = [strongSelf _associatedArtistBrowse];
        [SPAsyncLoading waitUntilLoaded:browse timeout:SMKSpotifyDefaultLoadingTimeout then:^(NSArray *loadedItems, NSArray *notLoadedItems) {
            SPImage *image = browse.firstPortrait;
            [SPAsyncLoading waitUntilLoaded:image timeout:SMKSpotifyDefaultLoadingTimeout then:^(NSArray *loadedItems, NSArray *notLoadedItems) {
                if(handler)
                    handler(image.image, browse.loadError);
            }];
        }];
    }];
}

- (SPArtistBrowse *)_associatedArtistBrowse
{
    __block SPArtistBrowse *browse = [self associatedValueForKey:SMKSPArtistBrowseKey];
    if (!browse) {
        dispatch_sync([SPSession libSpotifyQueue], ^{
            browse = [SPArtistBrowse browseArtist:self inSession:self.session type:SP_ARTISTBROWSE_NO_TRACKS];
        });
        [self associateValue:browse withKey:SMKSPArtistBrowseKey];
    }
    return browse;
}

- (NSArray *)_albumsFromBrowse:(SPArtistBrowse *)browse
               sortDescriptors:(NSArray *)sortDescriptors
                     predicate:(NSPredicate *)predicate
                    fetchLimit:(NSUInteger)limit
{
    NSMutableArray *albums = [NSMutableArray arrayWithArray:browse.albums];
    [albums SMK_processWithSortDescriptors:sortDescriptors predicate:predicate fetchLimit:limit];
    return albums;
}

@end
