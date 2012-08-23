// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SMKiTunesAlbum.h instead.

#import <CoreData/CoreData.h>
#import "SMKiTunesObject.h"

extern const struct SMKiTunesAlbumAttributes {
	__unsafe_unretained NSString *isCompilation;
	__unsafe_unretained NSString *rating;
	__unsafe_unretained NSString *releaseYear;
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




@property (nonatomic, strong) NSNumber* isCompilation;


@property BOOL isCompilationValue;
- (BOOL)isCompilationValue;
- (void)setIsCompilationValue:(BOOL)value_;

//- (BOOL)validateIsCompilation:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* rating;


@property int32_t ratingValue;
- (int32_t)ratingValue;
- (void)setRatingValue:(int32_t)value_;

//- (BOOL)validateRating:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* releaseYear;


@property int32_t releaseYearValue;
- (int32_t)releaseYearValue;
- (void)setReleaseYearValue:(int32_t)value_;

//- (BOOL)validateReleaseYear:(id*)value_ error:(NSError**)error_;





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


- (NSNumber*)primitiveIsCompilation;
- (void)setPrimitiveIsCompilation:(NSNumber*)value;

- (BOOL)primitiveIsCompilationValue;
- (void)setPrimitiveIsCompilationValue:(BOOL)value_;




- (NSNumber*)primitiveRating;
- (void)setPrimitiveRating:(NSNumber*)value;

- (int32_t)primitiveRatingValue;
- (void)setPrimitiveRatingValue:(int32_t)value_;




- (NSNumber*)primitiveReleaseYear;
- (void)setPrimitiveReleaseYear:(NSNumber*)value;

- (int32_t)primitiveReleaseYearValue;
- (void)setPrimitiveReleaseYearValue:(int32_t)value_;





- (SMKiTunesArtist*)primitiveArtist;
- (void)setPrimitiveArtist:(SMKiTunesArtist*)value;



- (NSMutableSet*)primitiveTracks;
- (void)setPrimitiveTracks:(NSMutableSet*)value;


@end
