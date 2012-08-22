#import "_SMKiTunesTrack.h"
#import "SMKTrack.h"

@interface SMKiTunesTrack : _SMKiTunesTrack <SMKTrack> {}
/** Always returns 0 since iTunes doesn't use popularity indexes */
- (NSNumber *)popularity;

/** Always returns NO since this info is not available */
- (NSNumber *)isExplicit;
- (NSNumber *)isClean;

/** Returns YES when the song has valid bookmark data */
- (BOOL)canStream;
@end
