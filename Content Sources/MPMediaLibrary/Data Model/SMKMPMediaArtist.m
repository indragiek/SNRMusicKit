//
//  SMKMPMediaArtist.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-27.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SMKMPMediaArtist.h"
#import "SMKMPMediaContentSource.h"
#import "SMKMPMediaHelpers.h"

@interface SMKMPMediaAlbum (SMKInternal)
- (id)initWithRepresentedObject:(MPMediaItemCollection *)object contentSource:(id<SMKContentSource>)contentSource;
@end

@implementation SMKMPMediaArtist

- (id)initWithRepresentedObject:(MPMediaItemCollection *)object contentSource:(id<SMKContentSource>)contentSource
{
    if ((self = [super init])) {
        _representedObject = object;
        _contentSource = contentSource;
    }
    return self;
}

#pragma mark - SMKContentObject

- (NSString *)uniqueIdentifier
{
    return [self.representedObject valueForProperty:MPMediaItemPropertyPersistentID];
}

- (NSString *)name
{
    NSString *albumArtist = [self.representedObject.representativeItem valueForProperty:MPMediaItemPropertyAlbumArtist];
    NSString *artist = [self.representedObject.representativeItem valueForProperty:MPMediaItemPropertyArtist];
    return albumArtist ?: artist;
}

+ (NSSet *)supportedSortKeys
{
    return [NSSet setWithObjects:@"name", nil];
}

#pragma mark - SMKArtist

- (void)fetchAlbumsWithSortDescriptors:(NSArray *)sortDescriptors
                             predicate:(id)predicate
                     completionHandler:(void(^)(NSArray *albums, NSError *error))handler
{
    __weak SMKMPMediaArtist *weakSelf = self;
    dispatch_async([(SMKMPMediaContentSource*)self.contentSource queryQueue], ^{
        SMKMPMediaArtist *strongSelf = weakSelf;
        MPMediaQuery *albumsQuery = [MPMediaQuery albumsQuery];
        MPMediaItem *item = strongSelf.representedObject.representativeItem;
        MPMediaPropertyPredicate *artistPredicate = [SMKMPMediaHelpers predicateForArtistNameOfItem:item];
        if (artistPredicate) {
            NSMutableSet *predicates = [NSMutableSet setWithObject:artistPredicate];
            if (predicate)
                [predicates addObjectsFromArray:[[(SMKMPMediaPredicate *)predicate predicates] allObjects]];
            albumsQuery.filterPredicates = predicates;
            NSArray *collections = albumsQuery.collections;
            NSMutableArray *albums = [NSMutableArray arrayWithCapacity:[collections count]];
            [collections enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                SMKMPMediaAlbum *album = [[SMKMPMediaAlbum alloc] initWithRepresentedObject:obj contentSource:strongSelf.contentSource];
                [albums addObject:album];
            }];
            if ([sortDescriptors count])
                [albums sortUsingDescriptors:sortDescriptors];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (handler) handler(albums, nil);
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (handler) handler(nil, nil);
            });
        }
    });
}
@end
