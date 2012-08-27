#import "SMKiTunesAlbum.h"
#import "NSManagedObjectContext+SMKAdditions.h"
#import "SMKiTunesConstants.h"
#import "SMKiTunesTrack.h"
#import "SMKManagedObjectContext.h"

@implementation SMKiTunesAlbum

- (void)fetchTracksWithSortDescriptors:(NSArray *)sortDescriptors
                             predicate:(NSPredicate *)predicate
                     completionHandler:(void(^)(NSArray *tracks, NSError *error))handler
{
    SMKManagedObjectContext *context = (SMKManagedObjectContext *)[self managedObjectContext];
    NSPredicate *finalPredicate = [self _compoundTrackPredicateWithPredicate:predicate];
    [context SMK_asyncFetchWithEntityName:SMKiTunesEntityNameTrack
                                              sortDescriptors:sortDescriptors
                                                    predicate:finalPredicate
                                                    batchSize:context.defaultFetchBatchSize
                                                   fetchLimit:0
                                            completionHandler:handler];
}

+ (NSSet *)supportedSortKeys
{
    return [NSSet setWithObjects:@"name", @"releaseYear", @"artist", @"isCompilation", @"rating", nil];
}

- (NSTimeInterval)duration
{
    return [[self valueForKey:@"tracks.@sum.duration"] floatValue];
}

- (BOOL)isCompilation
{
    return [self cd_isCompilationValue];
}

- (NSUInteger)releaseYear
{
    return [self cd_releaseYearValue];
}

- (NSUInteger)rating
{
    return [self cd_ratingValue];
}

#pragma mark - Private

- (NSPredicate *)_compoundTrackPredicateWithPredicate:(NSPredicate *)predicate
{
    NSPredicate *basePredicate = [NSPredicate predicateWithFormat:@"album == %@", self];
    if (predicate)
        basePredicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[basePredicate, predicate]];
    return basePredicate;
}
@end
