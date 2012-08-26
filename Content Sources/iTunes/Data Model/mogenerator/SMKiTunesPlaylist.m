#import "SMKiTunesPlaylist.h"
#import "NSManagedObjectContext+SMKAdditions.h"
#import "SMKiTunesConstants.h"
#import "SMKManagedObjectContext.h"

@implementation SMKiTunesPlaylist

- (void)fetchTracksWithCompletionHandler:(void(^)(NSArray *tracks, NSError *error))handler
{
    NSUInteger batchSize = [(SMKManagedObjectContext *)[self managedObjectContext] defaultFetchBatchSize];
    [[self managedObjectContext] SMK_asyncFetchWithEntityName:SMKiTunesEntityNameTrack
                                              sortDescriptors:nil
                                                    predicate:[NSPredicate predicateWithFormat:@"%@ in playlists", self]
                                                    batchSize:batchSize
                                                   fetchLimit:0
                                            completionHandler:handler];
}

- (BOOL)isEditable { return NO; }

- (NSString *)uniqueIdentifier
{
    return self.identifier;
}

@end
