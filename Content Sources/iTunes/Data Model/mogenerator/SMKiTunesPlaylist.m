#import "SMKiTunesPlaylist.h"
#import "NSManagedObjectContext+SMKAdditions.h"
#import "SMKiTunesConstants.h"
#import "SMKManagedObjectContext.h"

@implementation SMKiTunesPlaylist

- (void)fetchTracksWithCompletionHandler:(void(^)(NSArray *tracks, NSError *error))handler
{
    SMKManagedObjectContext *context = (SMKManagedObjectContext *)[self managedObjectContext];
    [context SMK_asyncFetchWithEntityName:SMKiTunesEntityNameTrack
                                              sortDescriptors:nil
                                                    predicate:[NSPredicate predicateWithFormat:@"%@ in playlists", self]
                                                    batchSize:context.defaultFetchBatchSize
                                                   fetchLimit:0
                                            completionHandler:handler];
}

- (BOOL)isEditable { return NO; }

- (NSString *)uniqueIdentifier
{
    return self.identifier;
}

@end
