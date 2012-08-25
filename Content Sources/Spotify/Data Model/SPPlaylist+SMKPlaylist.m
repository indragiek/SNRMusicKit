//
//  SPPlaylist+SMKPlaylist.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-24.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SPPlaylist+SMKPlaylist.h"
#import "SPUser+SMKUser.h"
#import "SPAlbum+SMKAlbum.h"
#import "SPArtist+SMKArtist.h"
#import "NSObject+SMKSpotifyAdditions.h"
#import "NSMutableArray+SMKAdditions.h"
#import "SMKSpotifyHelpers.h"

#import "SMKSpotifyConstants.h"
#import "SMKSpotifyContentSource.h"


@interface SPPlaylist (SMKInternal)
@property (nonatomic, readwrite, assign) __unsafe_unretained SPSession *session;
@end

@implementation SPPlaylist (SMKPlaylist)

#pragma mark - SMKPlaylist

- (NSArray *)tracksWithSortDescriptors:(NSArray *)sortDescriptors
                             predicate:(NSPredicate *)predicate
                             batchSize:(NSUInteger)batchSize
                            fetchLimit:(NSUInteger)fetchLimit
                             withError:(NSError **)error
{
    return [SMKSpotifyHelpers loadItemsSynchronously:self.items
                                     sortDescriptors:sortDescriptors
                                           predicate:predicate
                                          fetchLimit:fetchLimit];
}

- (void)fetchTracksWithSortDescriptors:(NSArray *)sortDescriptors
                             predicate:(NSPredicate *)predicate
                             batchSize:(NSUInteger)batchSize
                            fetchlimit:(NSUInteger)fetchLimit
                     completionHandler:(void(^)(NSArray *tracks, NSError *error))handler
{
    dispatch_queue_t queue = [(SMKSpotifyContentSource *)self.session spotifyLocalQueue];
    [SMKSpotifyHelpers loadItemsAynchronously:self.items
                              sortDescriptors:sortDescriptors
                                    predicate:predicate
                                   fetchLimit:fetchLimit
                                 sortingQueue:queue
                            completionHandler:handler];
}

- (BOOL)isEditable
{
    return YES;
}

- (id<SMKUser>)user
{
    return self.owner;
}

- (NSString *)extendedDescription
{
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
    return [NSSet setWithObjects:@"name", @"extendedDescription", @"items", nil];
}

- (id<SMKContentSource>)contentSource
{
    return (id<SMKContentSource>)self.session;
}

#pragma mark - SMKArtworkObject

- (SMKPlatformNativeImage *)artworkWithSize:(SMKArtworkSize)size error:(NSError **)error
{
    [self.image SMK_spotifyWaitUntilLoaded];
    return [self.image image];
}

- (void)fetchArtworkWithSize:(SMKArtworkSize)size
       withCompletionHandler:(void(^)(SMKPlatformNativeImage *image, NSError *error))handler
{
    __weak SPPlaylist *weakSelf = self;
    [self.image SMK_spotifyWaitAsyncThen:^{
        SPPlaylist *strongSelf = weakSelf;
        if (handler) handler(strongSelf.image.image, nil);
    }];
}

#pragma mark - SMKWebObject

- (NSURL *)webURL
{
    return self.spotifyURL;
}
@end
