#import "_SMKiTunesTrack.h"
#import "SMKTrack.h"

@interface SMKiTunesTrack : _SMKiTunesTrack <SMKTrack> {}
/** Always returns 0 since iTunes doesn't use popularity indexes */
- (NSNumber *)popularity;
@end
