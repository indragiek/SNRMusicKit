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
@end
