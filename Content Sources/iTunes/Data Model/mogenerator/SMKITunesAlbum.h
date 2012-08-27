#import "_SMKiTunesAlbum.h"
#import "SMKAlbum.h"

@interface SMKiTunesAlbum : _SMKiTunesAlbum <SMKAlbum> {}
@property (nonatomic, assign, readonly) NSTimeInterval duration;
@property (nonatomic, assign, readonly) BOOL isCompilation;
@property (nonatomic, assign, readonly) NSUInteger releaseYear;
@property (nonatomic, assign, readonly) NSUInteger rating;
@end
