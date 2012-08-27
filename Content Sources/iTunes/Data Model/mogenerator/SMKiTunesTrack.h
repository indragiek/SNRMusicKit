#import "_SMKiTunesTrack.h"
#import "SMKTrack.h"

@interface SMKiTunesTrack : _SMKiTunesTrack <SMKTrack> {}
// SMKTrack @optional
@property (nonatomic, assign, readonly) NSUInteger trackNumber;
@property (nonatomic, assign, readonly) NSUInteger discNumber;
@property (nonatomic, assign, readonly) NSUInteger rating;
@property (nonatomic, assign, readonly) BOOL isExplicit;
@property (nonatomic, assign, readonly) BOOL isClean;
@property (nonatomic, strong) NSString *genre;
@property (nonatomic, strong, readonly) NSURL *playbackURL;
@end
