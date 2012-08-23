// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SMKiTunesPlaylist.h instead.

#import <CoreData/CoreData.h>
#import "SMKiTunesObject.h"

extern const struct SMKiTunesPlaylistAttributes {
} SMKiTunesPlaylistAttributes;

extern const struct SMKiTunesPlaylistRelationships {
	__unsafe_unretained NSString *tracks;
} SMKiTunesPlaylistRelationships;

extern const struct SMKiTunesPlaylistFetchedProperties {
} SMKiTunesPlaylistFetchedProperties;

@class SMKiTunesTrack;


@interface SMKiTunesPlaylistID : NSManagedObjectID {}
@end

@interface _SMKiTunesPlaylist : SMKiTunesObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SMKiTunesPlaylistID*)objectID;





@property (nonatomic, strong) NSOrderedSet* tracks;

- (NSMutableOrderedSet*)tracksSet;





@end

@interface _SMKiTunesPlaylist (CoreDataGeneratedAccessors)

- (void)addTracks:(NSOrderedSet*)value_;
- (void)removeTracks:(NSOrderedSet*)value_;
- (void)addTracksObject:(SMKiTunesTrack*)value_;
- (void)removeTracksObject:(SMKiTunesTrack*)value_;

@end

@interface _SMKiTunesPlaylist (CoreDataGeneratedPrimitiveAccessors)



- (NSMutableOrderedSet*)primitiveTracks;
- (void)setPrimitiveTracks:(NSMutableOrderedSet*)value;


@end
