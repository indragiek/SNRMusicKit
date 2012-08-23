#import "SMKiTunesAlbum.h"
#import "NSManagedObjectContext+SMKAdditions.h"
#import "SMKiTunesConstants.h"
#import "SMKiTunesTrack.h"

@implementation SMKiTunesAlbum

- (NSArray *)tracksWithSortDescriptors:(NSArray *)sortDescriptors
                             predicate:(NSPredicate *)predicate
                             batchSize:(NSUInteger)batchSize
                            fetchLimit:(NSUInteger)fetchLimit
                                 error:(NSError **)error
{
    NSPredicate *finalPredicate = [self _compoundTrackPredicateWithPredicate:predicate];
    return [[self managedObjectContext] SMK_fetchWithEntityName:SMKiTunesEntityNameTrack
                                                sortDescriptors:sortDescriptors
                                                      predicate:finalPredicate
                                                      batchSize:batchSize
                                                     fetchLimit:fetchLimit
                                                          error:error];
}

- (void)fetchTracksWithSortDescriptors:(NSArray *)sortDescriptors
                             predicate:(NSPredicate *)predicate
                             batchSize:(NSUInteger)batchSize
                            fetchLimit:(NSUInteger)fetchLimit
                     completionHandler:(void(^)(NSArray *tracks, NSError *error))handler
{
    NSPredicate *finalPredicate = [self _compoundTrackPredicateWithPredicate:predicate];
    [[self managedObjectContext] SMK_asyncFetchWithEntityName:SMKiTunesEntityNameTrack
                                              sortDescriptors:sortDescriptors
                                                    predicate:finalPredicate
                                                    batchSize:batchSize
                                                   fetchLimit:fetchLimit
                                            completionHandler:handler];
}

+ (NSSet *)supportedSortKeys
{
    return [NSSet setWithObjects:@"name", @"releaseYear", @"artist", @"isCompilation", @"rating", nil];
}

- (NSDate *)releaseDate
{
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    [comp setDay:1];
    [comp setMonth:1];
    [comp setYear:[[self releaseYear] unsignedIntegerValue]];
    [comp setHour:12];
    [comp setMinute:0];
    [comp setSecond:0];
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    return [cal dateFromComponents:comp];
}

- (NSNumber *)duration
{
    NSUInteger totalDuration = 0;
    for (SMKiTunesTrack *track in self.tracks) {
        totalDuration += [[track duration] unsignedIntegerValue];
    }
    return @(totalDuration);
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
