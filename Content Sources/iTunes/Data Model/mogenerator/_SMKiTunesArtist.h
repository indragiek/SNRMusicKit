// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SMKiTunesArtist.h instead.

#import <CoreData/CoreData.h>
#import "SMKiTunesObject.h"

extern const struct SMKiTunesArtistAttributes {
} SMKiTunesArtistAttributes;

extern const struct SMKiTunesArtistRelationships {
	__unsafe_unretained NSString *albums;
} SMKiTunesArtistRelationships;

extern const struct SMKiTunesArtistFetchedProperties {
} SMKiTunesArtistFetchedProperties;

@class SMKiTunesAlbum;


@interface SMKiTunesArtistID : NSManagedObjectID {}
@end

@interface _SMKiTunesArtist : SMKiTunesObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SMKiTunesArtistID*)objectID;





@property (nonatomic, strong) NSSet* albums;

- (NSMutableSet*)albumsSet;





@end

@interface _SMKiTunesArtist (CoreDataGeneratedAccessors)

- (void)addAlbums:(NSSet*)value_;
- (void)removeAlbums:(NSSet*)value_;
- (void)addAlbumsObject:(SMKiTunesAlbum*)value_;
- (void)removeAlbumsObject:(SMKiTunesAlbum*)value_;

@end

@interface _SMKiTunesArtist (CoreDataGeneratedPrimitiveAccessors)



- (NSMutableSet*)primitiveAlbums;
- (void)setPrimitiveAlbums:(NSMutableSet*)value;


@end
