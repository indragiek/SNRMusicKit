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
#import "SMKAVQueuePlayer.h"
#import "SMKMPMusicPlayer.h"

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
    return [self.representedObject valueForProperty:MPMediaItemPropertyPersistentID];
}

- (NSString *)name
{
    return [self.representedObject valueForProperty:MPMediaItemPropertyTitle];
}

+ (NSSet *)supportedSortKeys
{
    return [NSSet setWithObjects:@"name", @"artistName", @"albumArtistName", @"duration", @"composer", @"trackNumber", @"discNumber", @"playCount", @"lyrics", @"genre", @"rating", @"lastPlayedDate", nil];
}

- (Class)playerClass
{
    return (self.playbackURL != nil) ? [SMKAVQueuePlayer class] : [SMKMPMusicPlayer class];
}

#pragma mark - SMKTrack

- (id<SMKAlbum>)album
{
    NSNumber *albumPersistentID = [self.representedObject valueForProperty:MPMediaItemPropertyAlbumPersistentID];
    MPMediaQuery *albumQuery = [MPMediaQuery albumsQuery];
    MPMediaPropertyPredicate *albumPredicate = [MPMediaPropertyPredicate predicateWithValue:albumPersistentID forProperty:MPMediaItemPropertyAlbumPersistentID];
    albumQuery.filterPredicates = [NSSet setWithObject:albumPredicate];
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
    return [self.representedObject valueForProperty:MPMediaItemPropertyArtist];
}

- (NSString *)albumArtistName
{
    return [self.representedObject valueForProperty:MPMediaItemPropertyAlbumArtist];
}

- (NSTimeInterval)duration
{
    return [[self.representedObject valueForProperty:MPMediaItemPropertyPlaybackDuration] doubleValue];
}

- (NSString *)composer
{
    return [self.representedObject valueForProperty:MPMediaItemPropertyComposer];
}

- (NSUInteger)trackNumber
{
    return [[self.representedObject valueForProperty:MPMediaItemPropertyAlbumTrackNumber] unsignedIntegerValue];
}

- (NSUInteger)discNumber
{
    return [[self.representedObject valueForProperty:MPMediaItemPropertyDiscNumber] unsignedIntegerValue];
}

- (NSUInteger)playCount
{
    return [[self.representedObject valueForProperty:MPMediaItemPropertyPlayCount] unsignedIntegerValue];
}

- (NSString *)lyrics
{
    return [self.representedObject valueForProperty:MPMediaItemPropertyLyrics];
}

- (NSString *)genre
{
    return [self.representedObject valueForProperty:MPMediaItemPropertyGenre];
}

- (NSUInteger)rating
{
    return [[self.representedObject valueForProperty:MPMediaItemPropertyRating] unsignedIntegerValue];
}

- (NSDate *)lastPlayedDate
{
    return [self.representedObject valueForProperty:MPMediaItemPropertyLastPlayedDate];
}

- (NSURL *)playbackURL
{
    return [self.representedObject valueForProperty:MPMediaItemPropertyAssetURL];
}
@end
