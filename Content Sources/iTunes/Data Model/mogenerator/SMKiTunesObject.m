#import "SMKiTunesObject.h"
#import "NSManagedObjectContext+SMKAdditions.h"
#import "NSString+SMKAdditions.h"

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

+ (NSString *)sortingNameForName:(NSString *)name
{
    return [name SMK_normalizedString];
}

#pragma mark - Accessors

- (void)setName:(NSString *)name
{
    [self willChangeValueForKey:@"name"];
    [self setPrimitiveName:name];
    [self didChangeValueForKey:@"name"];
    [self setNormalizedName:[[self class] sortingNameForName:name]];
}
@end
