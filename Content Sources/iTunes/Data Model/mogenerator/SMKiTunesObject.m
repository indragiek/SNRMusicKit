#import "SMKiTunesObject.h"
#import "NSManagedObjectContext+SMKAdditions.h"
#import "NSString+SMKAdditions.h"
#import "SMKManagedObjectContext.h"

@implementation SMKiTunesObject

- (NSString *)uniqueIdentifier
{
    return [[[self objectID] URIRepresentation] absoluteString];
}

- (id<SMKContentSource>)contentSource
{
    return [(SMKManagedObjectContext *)[self managedObjectContext] SMK_contentSource];
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
