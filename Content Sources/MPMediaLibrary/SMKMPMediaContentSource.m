//
//  SMKMPMediaContentSource.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-24.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SMKMPMediaContentSource.h"
#import <MediaPlayer/MediaPlayer.h>

@interface SMKMPMediaPlaylist (SMKInternal)
- (id)initWithRepresentedObject:(MPMediaItemCollection*)object contentSource:(id<SMKContentSource>)contentSource;
@end

@implementation SMKMPMediaContentSource

- (id)init
{
    if ((self = [super init])) {
        _queryQueue = dispatch_queue_create("com.indragie.SNRMusicKit.MPMediaQueryQueue", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (void)dealloc
{
    dispatch_release(_queryQueue);
}

- (void)fetchPlaylistsWithSortDescriptors:(NSArray *)sortDescriptors
                                predicate:(SMKMPMediaPredicate *)predicate
                        completionHandler:(void(^)(NSArray *playlists, NSError *error))handler
{
    __weak SMKMPMediaContentSource *weakSelf = self;
    dispatch_async(_queryQueue, ^{
        SMKMPMediaContentSource *strongSelf = weakSelf;
        MPMediaQuery *playlistsQuery = [MPMediaQuery playlistsQuery];
        if (predicate) playlistsQuery.filterPredicates = predicate.predicates;
        NSArray *collections = playlistsQuery.collections;
        NSMutableArray *playlists = [NSMutableArray arrayWithCapacity:[collections count]];
        [collections enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            SMKMPMediaPlaylist *playlist = [[SMKMPMediaPlaylist alloc] initWithRepresentedObject:obj contentSource:strongSelf];
            [playlists addObject:playlist];
        }];
        if ([sortDescriptors count])
            [playlists sortUsingDescriptors:sortDescriptors];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (handler) handler(playlists, nil);
        });
    });
}

+ (Class)predicateClass { return [SMKMPMediaPredicate class]; }
@end
