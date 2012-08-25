// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SMKiTunesAlbum.h instead.

#import <CoreData/CoreData.h>
#import "SMKiTunesObject.h"

extern const struct SMKiTunesAlbumAttributes {
	__unsafe_unretained NSString *cd_isCompilation;
	__unsafe_unretained NSString *cd_rating;
	__unsafe_unretained NSString *cd_releaseYear;
} SMKiTunesAlbumAttributes;

extern const struct SMKiTunesAlbumRelationships {
	__unsafe_unretained NSString *artist;
	__unsafe_unretained NSString *tracks;
} SMKiTunesAlbumRelationships;

extern const struct SMKiTunesAlbumFetchedProperties {
} SMKiTunesAlbumFetchedProperties;

@class SMKiTunesArtist;
@class SMKiTunesTrack;





@interface SMKiTunesAlbumID : NSManagedObjectID {}
@end

@interface _SMKiTunesAlbum : SMKiTunesObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SMKiTunesAlbumID*)objectID;




@property (nonatomic, strong) NSNumber* cd_isCompilation;


@property BOOL cd_isCompilationValue;
- (BOOL)cd_isCompilationValue;
- (void)setCd_isCompilationValue:(BOOL)value_;

//- (BOOL)validateCd_isCompilation:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* cd_rating;


@property int32_t cd_ratingValue;
- (int32_t)cd_ratingValue;
- (void)setCd_ratingValue:(int32_t)value_;

//- (BOOL)validateCd_rating:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* cd_releaseYear;


@property int32_t cd_releaseYearValue;
- (int32_t)cd_releaseYearValue;
- (void)setCd_releaseYearValue:(int32_t)value_;

//- (BOOL)validateCd_releaseYear:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) SMKiTunesArtist* artist;

//- (BOOL)validateArtist:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet* tracks;

- (NSMutableSet*)tracksSet;





@end

@interface _SMKiTunesAlbum (CoreDataGeneratedAccessors)

- (void)addTracks:(NSSet*)value_;
- (void)removeTracks:(NSSet*)value_;
- (void)addTracksObject:(SMKiTunesTrack*)value_;
- (void)removeTracksObject:(SMKiTunesTrack*)value_;

@end

@interface _SMKiTunesAlbum (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveCd_isCompilation;
- (void)setPrimitiveCd_isCompilation:(NSNumber*)value;

- (BOOL)primitiveCd_isCompilationValue;
- (void)setPrimitiveCd_isCompilationValue:(BOOL)value_;




- (NSNumber*)primitiveCd_rating;
- (void)setPrimitiveCd_rating:(NSNumber*)value;

- (int32_t)primitiveCd_ratingValue;
- (void)setPrimitiveCd_ratingValue:(int32_t)value_;




- (NSNumber*)primitiveCd_releaseYear;
- (void)setPrimitiveCd_releaseYear:(NSNumber*)value;

- (int32_t)primitiveCd_releaseYearValue;
- (void)setPrimitiveCd_releaseYearValue:(int32_t)value_;





- (SMKiTunesArtist*)primitiveArtist;
- (void)setPrimitiveArtist:(SMKiTunesArtist*)value;



- (NSMutableSet*)primitiveTracks;
- (void)setPrimitiveTracks:(NSMutableSet*)value;


@end
