#import "SMKiTunesArtist.h"
#import "SMKiTunesConstants.h"
#import "NSManagedObjectContext+SMKAdditions.h"
#import "SMKManagedObjectContext.h"
#import "NSString+SMKAdditions.h"

@implementation SMKiTunesArtist

- (void)fetchAlbumsWithSortDescriptors:(NSArray *)sortDescriptors
                             predicate:(NSPredicate *)predicate
                     completionHandler:(void(^)(NSArray *albums, NSError *error))handler
{
    NSPredicate *finalPredicate = [self _compoundAlbumPredicateWithPredicate:predicate];
    SMKManagedObjectContext *context = (SMKManagedObjectContext *)[self managedObjectContext];
    [context SMK_asyncFetchWithEntityName:SMKiTunesEntityNameArtist
                                              sortDescriptors:sortDescriptors
                                                    predicate:finalPredicate
                                                    batchSize:context.defaultFetchBatchSize
                                                   fetchLimit:0
                                            completionHandler:handler];
}

+ (NSString *)sortingNameForName:(NSString *)name
{
    NSArray *filterTerms = [NSArray arrayWithObjects:@"the ", @"a ", @"an ", nil];
    NSMutableString *sortString = [NSMutableString stringWithString:name];
    for (NSString *term in filterTerms) {
        NSRange range = [sortString rangeOfString:term options:NSCaseInsensitiveSearch];
        if ((range.location == 0) && (range.length > 0)) {
            [sortString replaceCharactersInRange:range withString:@""];
            break;
        }
    }
    return [sortString SMK_normalizedString];
}

#pragma mark - Private

- (NSPredicate *)_compoundAlbumPredicateWithPredicate:(NSPredicate *)predicate
{
    NSPredicate *basePredicate = [NSPredicate predicateWithFormat:@"artist == %@", self];
    if (predicate)
        basePredicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[basePredicate, predicate]];
    return basePredicate;
}
@end
