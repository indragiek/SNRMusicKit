//
//  SMKMPMediaAlbum.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-27.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SMKMPMediaAlbum.h"
#import "SMKMPMediaContentSource.h"
#import "SMKMPMediaHelpers.h"

@interface SMKMPMediaArtist (SMKInternal)
- (id)initWithRepresentedObject:(MPMediaItemCollection *)object contentSource:(id<SMKContentSource>)contentSource;
@end

@interface SMKMPMediaTrack (SMKInternal)
- (id)initWithRepresentedObject:(MPMediaItem*)object contentSource:(id<SMKContentSource>)contentSource;
@end

@implementation SMKMPMediaAlbum

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
    return [[self.representedObject valueForProperty:MPMediaItemPropertyPersistentID] stringValue];
}

- (NSString *)name
{
    return [self.representedObject.representativeItem valueForProperty:MPMediaItemPropertyAlbumTitle];
}

+ (NSSet *)supportedSortKeys
{
    return [NSSet setWithObjects:@"name", @"releaseYear", @"artist", @"rating", @"duration", @"isCompilation", nil];
}

#pragma mark - SMKArtworkObject

- (void)fetchArtworkWithSize:(SMKArtworkSize)size
       completionHandler:(void(^)(SMKPlatformNativeImage *image, NSError *error))handler
{
    CGSize targetSize = CGSizeZero;
    switch (size) {
        case SMKArtworkSizeSmallest:
            targetSize = CGSizeMake(72.0, 72.0);
            break;
        case SMKArtworkSizeSmall:
            targetSize = CGSizeMake(150.0, 150.0);
            break;
        case SMKArtworkSizeLarge:
            targetSize = CGSizeMake(300.0, 300.0);
            break;
        case SMKArtworkSizeLargest:
            targetSize = CGSizeMake(600.0, 600.0);
        default:
            break;
    }
    [self fetchArtworkWithTargetSize:targetSize completionHandler:handler];
}

- (void)fetchArtworkWithTargetSize:(CGSize)size completionHandler:(void(^)(SMKPlatformNativeImage *image, NSError *error))handler
{
    __weak SMKMPMediaAlbum *weakSelf = self;
    dispatch_async([(SMKMPMediaContentSource*)self.contentSource queryQueue], ^{
        SMKMPMediaAlbum *strongSelf = weakSelf;
        MPMediaItemArtwork *artwork = [strongSelf.representedObject.representativeItem valueForProperty:MPMediaItemPropertyArtwork];
        UIImage *image = [artwork imageWithSize:size];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (handler) handler(image, nil);
        });
    });
}

#pragma mark - SMKAlbum

- (id<SMKArtist>)artist
{
    MPMediaItem *representativeItem = self.representedObject.representativeItem;
    MPMediaQuery *artistQuery = [MPMediaQuery artistsQuery];
    MPMediaPropertyPredicate *artistPredicate = [SMKMPMediaHelpers predicateForArtistNameOfItem:representativeItem];
    artistQuery.filterPredicates = [NSSet setWithObject:artistPredicate];
    NSArray *collections = artistQuery.collections;
    if ([collections count]) {
        return [[SMKMPMediaArtist alloc] initWithRepresentedObject:[collections objectAtIndex:0] contentSource:self.contentSource];
    }
    return nil;
}

- (NSUInteger)releaseYear
{
    NSDate *releaseDate = [self.representedObject.representativeItem valueForProperty:MPMediaItemPropertyReleaseDate];
    if (releaseDate) {
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:releaseDate];
        return [components year];
    }
    return 0;
}

- (NSUInteger)rating
{
    return [[self.representedObject.representativeItem valueForProperty:MPMediaItemPropertyRating] unsignedIntegerValue];
}

- (NSTimeInterval)duration
{
    NSTimeInterval totalDuration = 0.0;
    for (MPMediaItem *item in self.representedObject.items) {
        totalDuration += [[item valueForProperty:MPMediaItemPropertyPlaybackDuration] doubleValue];
    }
    return totalDuration;
}

- (void)fetchTracksWithSortDescriptors:(NSArray *)sortDescriptors
                             predicate:(id)predicate
                     completionHandler:(void(^)(NSArray *tracks, NSError *error))handler
{
    __weak SMKMPMediaAlbum *weakSelf = self;
    dispatch_async([(SMKMPMediaContentSource*)self.contentSource queryQueue], ^{
        SMKMPMediaAlbum *strongSelf = weakSelf;
        NSMutableArray *tracks = [NSMutableArray array];
        NSArray *items = nil;
        if (!predicate) {
            items = strongSelf.representedObject.items;
        } else {
            MPMediaQuery *songsQuery = [MPMediaQuery songsQuery];
            MPMediaPropertyPredicate *albumPredicate = [MPMediaPropertyPredicate predicateWithValue:[strongSelf.representedObject valueForProperty:MPMediaItemPropertyPersistentID] forProperty:MPMediaItemPropertyAlbumPersistentID];
            NSMutableSet *predicates = [NSMutableSet setWithObject:albumPredicate];
            if (predicate)
                [predicates addObjectsFromArray:[[(SMKMPMediaPredicate *)predicate predicates] allObjects]];
            items = songsQuery.items;
        }
        [items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            SMKMPMediaTrack *track = [[SMKMPMediaTrack alloc] initWithRepresentedObject:obj contentSource:strongSelf.contentSource];
            [tracks addObject:track];
        }];
        if ([sortDescriptors count])
            [tracks sortUsingDescriptors:sortDescriptors];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (handler) handler(tracks, nil);
        });
    });
}
@end
