// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SNRITunesAlbum.h instead.

#import <CoreData/CoreData.h>
#import "SNRiTunesObject.h"

extern const struct SNRITunesAlbumAttributes {
} SNRITunesAlbumAttributes;

extern const struct SNRITunesAlbumRelationships {
	__unsafe_unretained NSString *artist;
	__unsafe_unretained NSString *tracks;
} SNRITunesAlbumRelationships;

extern const struct SNRITunesAlbumFetchedProperties {
} SNRITunesAlbumFetchedProperties;

@class SNRiTunesArtist;
@class SNRiTunesTrack;


@interface SNRITunesAlbumID : NSManagedObjectID {}
@end

@interface _SNRITunesAlbum : SNRiTunesObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SNRITunesAlbumID*)objectID;





@property (nonatomic, strong) SNRiTunesArtist* artist;

//- (BOOL)validateArtist:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet* tracks;

- (NSMutableSet*)tracksSet;





@end

@interface _SNRITunesAlbum (CoreDataGeneratedAccessors)

- (void)addTracks:(NSSet*)value_;
- (void)removeTracks:(NSSet*)value_;
- (void)addTracksObject:(SNRiTunesTrack*)value_;
- (void)removeTracksObject:(SNRiTunesTrack*)value_;

@end

@interface _SNRITunesAlbum (CoreDataGeneratedPrimitiveAccessors)



- (SNRiTunesArtist*)primitiveArtist;
- (void)setPrimitiveArtist:(SNRiTunesArtist*)value;



- (NSMutableSet*)primitiveTracks;
- (void)setPrimitiveTracks:(NSMutableSet*)value;


@end
