#import "SMKiTunesObject.h"
#import "NSManagedObjectContext+SMKAdditions.h"

@implementation SMKiTunesObject

- (NSString *)uniqueIdentifier
{
    return [[[self objectID] URIRepresentation] absoluteString];
}

- (id<SMKContentSource>)contentSource
{
    return [[self managedObjectContext] contentSource];
}

+ (NSSet *)supportedSortKeys
{
    return [NSSet setWithObjects:@"name", nil];
}
@end
