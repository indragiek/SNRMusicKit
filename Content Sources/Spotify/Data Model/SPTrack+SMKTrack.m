//
//  SPTrack+SMKTrack.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-24.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SPTrack+SMKTrack.h"
#import "NSObject+SMKSpotifyAdditions.h"
#import "SPAlbum+SMKAlbum.h"
#import "SPArtist+SMKArtist.h"

@interface SPTrack (SMKInternal)
@property (nonatomic, readwrite, assign) __unsafe_unretained SPSession *session;
@end

@implementation SPTrack (SMKTrack)

- (id<SMKArtist>)artist
{
    return self.album.artist;
}

- (NSString *)artistName
{
    return self.album.artist.name;
}

- (NSString *)albumArtistName
{
    return [self artistName];
}

- (NSString *)uniqueIdentifier
{
    return [self.spotifyURL absoluteString];
}

- (id<SMKContentSource>)contentSource
{
    return (id<SMKContentSource>)self.session;
}

+ (NSSet *)supportedSortKeys
{
    return [NSSet setWithObjects:@"artist", @"artistName", @"albumArtistName", @"duration", @"trackNumber", @"discNumber", @"name", @"popularity", nil];
}

- (Class)playerClass
{
    return NSClassFromString(@"SMKSpotifyPlayer");
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
    [self SMK_spotifyWaitAsyncThen:^{
        [array addObject:self];
        dispatch_group_leave(group);
    }];
}
@end
