#import "_SMKiTunesObject.h"
#import "SMKContentSource.h"

@interface SMKiTunesObject : _SMKiTunesObject {}
- (NSString *)uniqueIdentifier;
- (id<SMKContentSource>)contentSource;
+ (NSSet *)supportedSortKeys;
@end
