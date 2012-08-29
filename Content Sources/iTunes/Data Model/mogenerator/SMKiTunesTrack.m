#import "SMKiTunesTrack.h"
#import "SMKiTunesAlbum.h"

@implementation SMKiTunesTrack

- (id<SMKArtist>)artist
{
    return [self.album artist];
}

- (NSString *)uniqueIdentifier
{
    return self.identifier;
}

- (NSTimeInterval)duration
{
    return [self cd_durationValue];
}

- (NSUInteger)trackNumber
{
    return [self cd_trackNumberValue];
}

- (NSUInteger)discNumber
{
    return [self cd_discNumberValue];
}

- (NSUInteger)rating
{
    return [self cd_ratingValue];
}

- (BOOL)isExplicit
{
    return [self cd_isExplicitValue];
}

- (BOOL)isClean
{
    return [self cd_isCleanValue];
}

- (NSURL *)playbackURL
{
    if (!self.bookmark) { return nil; }
    NSError *error = nil;
    NSURL *URL = [NSURL URLByResolvingBookmarkData:self.bookmark options:NSURLBookmarkResolutionWithoutUI relativeToURL:nil bookmarkDataIsStale:NULL error:&error];
    if (error) {
        NSLog(@"Error retrieving bookmark data for %@: %@ %@", self, error, [error userInfo]);
    }
    return URL;
}

+ (NSSet *)supportedSortKeys
{
    return [NSSet setWithObjects:@"album", @"duration", @"composer", @"trackNumber", @"discNumber", @"isExplicit", @"isClean", @"genre", @"rating", nil];
}

- (Class)playerClass
{
    return NSClassFromString(@"SMKAVQueuePlayer");
}
@end
