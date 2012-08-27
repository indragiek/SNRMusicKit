//
//  SMKMPMediaTrack.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-27.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SMKMPMediaTrack.h"
#import "SMKMPMediaAlbum.h"
#import "SMKMPMediaHelpers.h"

@interface SMKMPMediaAlbum (SMKInternal)
- (id)initWithRepresentedObject:(MPMediaItem*)object contentSource:(id<SMKContentSource>)contentSource;
@end

@implementation SMKMPMediaTrack

- (id)initWithRepresentedObject:(MPMediaItem*)object contentSource:(id<SMKContentSource>)contentSource
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
    return [self.representedObject valueForKey:MPMediaItemPropertyPersistentID];
}

- (NSString *)name
{
    return [self.representedObject valueForKey:MPMediaItemPropertyTitle];
}

+ (NSSet *)supportedSortKeys
{
    return [NSSet setWithObjects:@"name", @"artistName", @"albumArtistName", @"duration", @"composer", @"trackNumber", @"discNumber", @"playCount", @"lyrics", @"genre", @"rating", @"lastPlayedDate", nil];
}

#pragma mark - SMKTrack

- (id<SMKAlbum>)album
{
    NSString *albumTitle = [self.representedObject valueForKey:MPMediaItemPropertyAlbumTitle];
    if (![albumTitle length])
        return nil;
    MPMediaQuery *albumQuery = [MPMediaQuery albumsQuery];
    MPMediaPropertyPredicate *albumPredicate = [MPMediaPropertyPredicate predicateWithValue:albumTitle forProperty:MPMediaItemPropertyAlbumTitle];
    NSMutableSet *predicates = [NSMutableSet setWithObject:albumPredicate];
    MPMediaPropertyPredicate *artistPredicate = [SMKMPMediaHelpers predicateForArtistNameOfItem:self.representedObject];
    if (artistPredicate)
        [predicates addObject:artistPredicate];
    albumQuery.filterPredicates = [NSSet setWithObjects:albumPredicate, artistPredicate, nil];
    NSArray *collections = albumQuery.collections;
    if ([collections count]) {
        return [[SMKMPMediaAlbum alloc] initWithRepresentedObject:[collections objectAtIndex:0] contentSource:self.contentSource];
    }
    return nil;
}

- (id<SMKArtist>)artist
{
    return [self.album artist];
}

- (NSString *)artistName
{
    return [self.representedObject valueForKey:MPMediaItemPropertyArtist];
}

- (NSString *)albumArtistName
{
    return [self.representedObject valueForKey:MPMediaItemPropertyAlbumArtist];
}

- (NSTimeInterval)duration
{
    return [[self.representedObject valueForKey:MPMediaItemPropertyPlaybackDuration] doubleValue];
}

- (NSString *)composer
{
    return [self.representedObject valueForKey:MPMediaItemPropertyComposer];
}

- (NSUInteger)trackNumber
{
    return [[self.representedObject valueForKey:MPMediaItemPropertyAlbumTrackNumber] unsignedIntegerValue];
}

- (NSUInteger)discNumber
{
    return [[self.representedObject valueForKey:MPMediaItemPropertyDiscNumber] unsignedIntegerValue];
}

- (NSUInteger)playCount
{
    return [[self.representedObject valueForKey:MPMediaItemPropertyPlayCount] unsignedIntegerValue];
}

- (NSString *)lyrics
{
    return [self.representedObject valueForKey:MPMediaItemPropertyLyrics];
}

- (NSString *)genre
{
    return [self.representedObject valueForKey:MPMediaItemPropertyGenre];
}

- (NSUInteger)rating
{
    return [[self.representedObject valueForKey:MPMediaItemPropertyRating] unsignedIntegerValue];
}

- (NSDate *)lastPlayedDate
{
    return [self.representedObject valueForKey:MPMediaItemPropertyLastPlayedDate];
}

- (NSURL *)playbackURL
{
    return [self.representedObject valueForKey:MPMediaItemPropertyAssetURL];
}
@end
