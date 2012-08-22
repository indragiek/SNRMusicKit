// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SNRiTunesPlaylist.h instead.

#import <CoreData/CoreData.h>
#import "SNRiTunesObject.h"

extern const struct SNRiTunesPlaylistAttributes {
} SNRiTunesPlaylistAttributes;

extern const struct SNRiTunesPlaylistRelationships {
	__unsafe_unretained NSString *tracks;
} SNRiTunesPlaylistRelationships;

extern const struct SNRiTunesPlaylistFetchedProperties {
} SNRiTunesPlaylistFetchedProperties;

@class SNRiTunesTrack;


@interface SNRiTunesPlaylistID : NSManagedObjectID {}
@end

@interface _SNRiTunesPlaylist : SNRiTunesObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SNRiTunesPlaylistID*)objectID;





@property (nonatomic, strong) NSSet* tracks;

- (NSMutableSet*)tracksSet;





@end

@interface _SNRiTunesPlaylist (CoreDataGeneratedAccessors)

- (void)addTracks:(NSSet*)value_;
- (void)removeTracks:(NSSet*)value_;
- (void)addTracksObject:(SNRiTunesTrack*)value_;
- (void)removeTracksObject:(SNRiTunesTrack*)value_;

@end

@interface _SNRiTunesPlaylist (CoreDataGeneratedPrimitiveAccessors)



- (NSMutableSet*)primitiveTracks;
- (void)setPrimitiveTracks:(NSMutableSet*)value;


@end
