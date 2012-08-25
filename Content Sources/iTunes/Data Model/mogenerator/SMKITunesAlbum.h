#import "_SMKiTunesAlbum.h"
#import "SMKAlbum.h"

@interface SMKiTunesAlbum : _SMKiTunesAlbum <SMKAlbum> {}
- (NSTimeInterval)duration;
- (BOOL)isCompilation;
- (NSUInteger)releaseYear;
@end
