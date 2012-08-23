#import "_SMKiTunesObject.h"
#import "SMKContentSource.h"

@interface SMKiTunesObject : _SMKiTunesObject {}
- (NSString *)uniqueIdentifier;
- (id<SMKContentSource>)contentSource;
+ (NSSet *)supportedSortKeys;

+ (NSString *)sortingNameForName:(NSString *)name;
@end
