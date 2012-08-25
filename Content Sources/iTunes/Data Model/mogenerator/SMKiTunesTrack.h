#import "_SMKiTunesTrack.h"
#import "SMKTrack.h"

@interface SMKiTunesTrack : _SMKiTunesTrack <SMKTrack> {}
- (NSUInteger)trackNumber;
- (NSUInteger)discNumber;
- (BOOL)isExplicit;
- (BOOL)isClean;
@end
