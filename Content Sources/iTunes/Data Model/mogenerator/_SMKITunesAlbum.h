// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SMKITunesAlbum.h instead.

#import <CoreData/CoreData.h>
#import "SMKiTunesObject.h"

extern const struct SMKITunesAlbumAttributes {
} SMKITunesAlbumAttributes;

extern const struct SMKITunesAlbumRelationships {
	__unsafe_unretained NSString *artist;
	__unsafe_unretained NSString *tracks;
} SMKITunesAlbumRelationships;

extern const struct SMKITunesAlbumFetchedProperties {
} SMKITunesAlbumFetchedProperties;

@class SMKiTunesArtist;
@class SMKiTunesTrack;


@interface SMKITunesAlbumID : NSManagedObjectID {}
@end

@interface _SMKITunesAlbum : SMKiTunesObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SMKITunesAlbumID*)objectID;





@property (nonatomic, strong) SMKiTunesArtist* artist;

//- (BOOL)validateArtist:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet* tracks;

- (NSMutableSet*)tracksSet;





@end

@interface _SMKITunesAlbum (CoreDataGeneratedAccessors)

- (void)addTracks:(NSSet*)value_;
- (void)removeTracks:(NSSet*)value_;
- (void)addTracksObject:(SMKiTunesTrack*)value_;
- (void)removeTracksObject:(SMKiTunesTrack*)value_;

@end

@interface _SMKITunesAlbum (CoreDataGeneratedPrimitiveAccessors)



- (SMKiTunesArtist*)primitiveArtist;
- (void)setPrimitiveArtist:(SMKiTunesArtist*)value;



- (NSMutableSet*)primitiveTracks;
- (void)setPrimitiveTracks:(NSMutableSet*)value;


@end
