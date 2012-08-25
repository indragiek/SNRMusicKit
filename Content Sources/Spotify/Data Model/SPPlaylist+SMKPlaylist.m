//
//  SPPlaylist+SMKPlaylist.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-24.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SPPlaylist+SMKPlaylist.h"
#import "SPUser+SMKUser.h"
#import "SMKSpotifyConstants.h"
#import "NSObject+SMKSpotifyAdditions.h"

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
    [SPAsyncLoading waitUntilLoaded:self timeout:kSPAsyncLoadingDefaultTimeout then:^(NSArray *loadedItems, NSArray *notLoadedItems) {
        handler([self _flattenedTracksWithSortDescriptors:sortDescriptors
                                                predicate:predicate
                                               fetchLimit:fetchLimit], nil);
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
        handler(strongSelf.image.image, nil);
    }];
}

- (NSArray *)_flattenedTracksWithSortDescriptors:(NSArray *)sortDescriptors predicate:(NSPredicate *)predicate fetchLimit:(NSUInteger)fetchLimit
{
    NSMutableArray *tracks = [NSMutableArray array];
    [self.items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id item = [(SPPlaylistItem *)obj item];
        if ([item isKindOfClass:[SPTrack class]]) {
            [tracks addObject:item];
        } else if ([item isKindOfClass:[SPAlbum class]]) {
            
        }
    }];
}
@end
