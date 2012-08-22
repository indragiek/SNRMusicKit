// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SNRiTunesArtist.h instead.

#import <CoreData/CoreData.h>
#import "SNRiTunesObject.h"

extern const struct SNRiTunesArtistAttributes {
} SNRiTunesArtistAttributes;

extern const struct SNRiTunesArtistRelationships {
	__unsafe_unretained NSString *albums;
} SNRiTunesArtistRelationships;

extern const struct SNRiTunesArtistFetchedProperties {
} SNRiTunesArtistFetchedProperties;

@class SNRITunesAlbum;


@interface SNRiTunesArtistID : NSManagedObjectID {}
@end

@interface _SNRiTunesArtist : SNRiTunesObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SNRiTunesArtistID*)objectID;





@property (nonatomic, strong) NSSet* albums;

- (NSMutableSet*)albumsSet;





@end

@interface _SNRiTunesArtist (CoreDataGeneratedAccessors)

- (void)addAlbums:(NSSet*)value_;
- (void)removeAlbums:(NSSet*)value_;
- (void)addAlbumsObject:(SNRITunesAlbum*)value_;
- (void)removeAlbumsObject:(SNRITunesAlbum*)value_;

@end

@interface _SNRiTunesArtist (CoreDataGeneratedPrimitiveAccessors)



- (NSMutableSet*)primitiveAlbums;
- (void)setPrimitiveAlbums:(NSMutableSet*)value;


@end
