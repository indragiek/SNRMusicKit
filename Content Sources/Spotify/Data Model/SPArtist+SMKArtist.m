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
#import "SMKSpotifyHelpers.h"

static void* const SMKSPArtistBrowseKey = @"SMK_SPArtistBrowse";

@interface SPArtist (SMKInternal)
@property (nonatomic, readwrite, strong) SPSession *session;
@end

@implementation SPArtist (SMKArtist)

#pragma mark - SMKArtist

- (void)fetchAlbumsWithSortDescriptors:(NSArray *)sortDescriptors
                             predicate:(NSPredicate *)predicate
                     completionHandler:(void(^)(NSArray *albums, NSError *error))handler
{
    SPArtistBrowse *browse = [self SMK_associatedArtistBrowse];
    dispatch_queue_t queue = [(SMKSpotifyContentSource *)self.session spotifyLocalQueue];
    [SMKSpotifyHelpers loadItemsAynchronously:@[browse]
                              sortDescriptors:sortDescriptors
                                    predicate:predicate
                                 sortingQueue:queue
                            completionHandler:handler];
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

#pragma mark - SMKHierarchicalLoading

- (void)loadHierarchy:(dispatch_group_t)group array:(NSMutableArray *)array
{
    dispatch_group_enter(group);
    __weak SPArtist *weakSelf = self;
    [self SMK_spotifyWaitAsyncThen:^{
        SPArtist *strongSelf = weakSelf;
        SPArtistBrowse *browse = [strongSelf SMK_associatedArtistBrowse];
        [browse loadHierarchy:group array:array];
        dispatch_group_leave(group);
    }];
}

#pragma mark - SMKArtworkObject

- (void)fetchArtworkWithSize:(SMKArtworkSize)size
       completionHandler:(void(^)(SMKPlatformNativeImage *image, NSError *error))handler
{
    SPArtistBrowse *browse = [self SMK_associatedArtistBrowse];
    [browse SMK_spotifyWaitAsyncThen:^{
        SPImage *image = browse.firstPortrait;
        [image SMK_spotifyWaitAsyncThen:^{
            if (handler) handler(image.image, nil);
        }];
    }];
}

- (SPArtistBrowse *)SMK_associatedArtistBrowse
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
@end

@implementation SPArtistBrowse (SMKArtist)

#pragma mark - SMKHierarchicalLoading

- (void)loadHierarchy:(dispatch_group_t)group array:(NSMutableArray *)array
{
    __weak SPArtistBrowse *weakSelf = self;
    dispatch_group_enter(group);
    [self SMK_spotifyWaitAsyncThen:^{
        SPArtistBrowse *strongSelf = weakSelf;
        [strongSelf.albums enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [obj loadHierarchy:group array:array];
        }];
        dispatch_group_leave(group);
    }];
}
@end
