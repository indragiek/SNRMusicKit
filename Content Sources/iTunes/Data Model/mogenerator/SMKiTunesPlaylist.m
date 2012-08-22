#import "SMKiTunesPlaylist.h"
#import "NSManagedObjectContext+SMKAdditions.h"
#import "SMKiTunesConstants.h"

@interface SMKiTunesPlaylist ()
- (NSPredicate *)_compoundTrackPredicateWithPredicate:(NSPredicate *)predicate;
@end

@implementation SMKiTunesPlaylist

- (NSArray *)tracksWithSortDescriptors:(NSArray *)sortDescriptors predicate:(NSPredicate *)predicate batchSize:(NSUInteger)batchSize fetchLimit:(NSUInteger)fetchLimit withError:(NSError **)error
{
    NSPredicate *finalPredicate = [self _compoundTrackPredicateWithPredicate:predicate];
    return [[self managedObjectContext] SMK_fetchWithEntityName:SMKiTunesEntityNameTrack sortDescriptors:sortDescriptors predicate:finalPredicate batchSize:batchSize fetchLimit:fetchLimit error:error];
}

- (void)fetchTracksWithSortDescriptors:(NSArray *)sortDescriptors predicate:(NSPredicate *)predicate batchSize:(NSUInteger)batchSize fetchlimit:(NSUInteger)fetchLimit completionHandler:(void(^)(NSArray *tracks, NSError *error))handler
{
    NSPredicate *finalPredicate = [self _compoundTrackPredicateWithPredicate:predicate];
    [[self managedObjectContext] SMK_asyncFetchWithEntityName:SMKiTunesEntityNameTrack sortDescriptors:sortDescriptors predicate:finalPredicate batchSize:batchSize fetchLimit:fetchLimit completionHandler:handler];
}

- (BOOL)isEditable { return NO; }

#pragma mark - Private

- (NSPredicate *)_compoundTrackPredicateWithPredicate:(NSPredicate *)predicate
{
    NSPredicate *basePredicate = [NSPredicate predicateWithFormat:@"%@ in playlists", self];
    if (predicate)
        basePredicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[basePredicate, predicate]];
    return basePredicate;
}
@end
