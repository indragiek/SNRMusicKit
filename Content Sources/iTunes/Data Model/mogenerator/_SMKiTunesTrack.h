// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SMKiTunesTrack.h instead.

#import <CoreData/CoreData.h>
#import "SMKiTunesObject.h"

extern const struct SMKiTunesTrackAttributes {
	__unsafe_unretained NSString *albumArtistName;
	__unsafe_unretained NSString *artistName;
	__unsafe_unretained NSString *bookmark;
	__unsafe_unretained NSString *compilation;
	__unsafe_unretained NSString *composer;
	__unsafe_unretained NSString *dateAdded;
	__unsafe_unretained NSString *dateModified;
	__unsafe_unretained NSString *discNumber;
	__unsafe_unretained NSString *duration;
	__unsafe_unretained NSString *genre;
	__unsafe_unretained NSString *isClean;
	__unsafe_unretained NSString *isExplicit;
	__unsafe_unretained NSString *rating;
	__unsafe_unretained NSString *trackNumber;
} SMKiTunesTrackAttributes;

extern const struct SMKiTunesTrackRelationships {
	__unsafe_unretained NSString *album;
	__unsafe_unretained NSString *playlists;
} SMKiTunesTrackRelationships;

extern const struct SMKiTunesTrackFetchedProperties {
} SMKiTunesTrackFetchedProperties;

@class SMKiTunesAlbum;
@class SMKiTunesPlaylist;
















@interface SMKiTunesTrackID : NSManagedObjectID {}
@end

@interface _SMKiTunesTrack : SMKiTunesObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SMKiTunesTrackID*)objectID;




@property (nonatomic, strong) NSString* albumArtistName;


//- (BOOL)validateAlbumArtistName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* artistName;


//- (BOOL)validateArtistName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSData* bookmark;


//- (BOOL)validateBookmark:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* compilation;


@property BOOL compilationValue;
- (BOOL)compilationValue;
- (void)setCompilationValue:(BOOL)value_;

//- (BOOL)validateCompilation:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* composer;


//- (BOOL)validateComposer:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* dateAdded;


//- (BOOL)validateDateAdded:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* dateModified;


//- (BOOL)validateDateModified:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* discNumber;


@property int32_t discNumberValue;
- (int32_t)discNumberValue;
- (void)setDiscNumberValue:(int32_t)value_;

//- (BOOL)validateDiscNumber:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* duration;


@property int64_t durationValue;
- (int64_t)durationValue;
- (void)setDurationValue:(int64_t)value_;

//- (BOOL)validateDuration:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* genre;


//- (BOOL)validateGenre:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* isClean;


@property BOOL isCleanValue;
- (BOOL)isCleanValue;
- (void)setIsCleanValue:(BOOL)value_;

//- (BOOL)validateIsClean:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* isExplicit;


@property BOOL isExplicitValue;
- (BOOL)isExplicitValue;
- (void)setIsExplicitValue:(BOOL)value_;

//- (BOOL)validateIsExplicit:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* rating;


@property int32_t ratingValue;
- (int32_t)ratingValue;
- (void)setRatingValue:(int32_t)value_;

//- (BOOL)validateRating:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* trackNumber;


@property int32_t trackNumberValue;
- (int32_t)trackNumberValue;
- (void)setTrackNumberValue:(int32_t)value_;

//- (BOOL)validateTrackNumber:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) SMKiTunesAlbum* album;

//- (BOOL)validateAlbum:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet* playlists;

- (NSMutableSet*)playlistsSet;





@end

@interface _SMKiTunesTrack (CoreDataGeneratedAccessors)

- (void)addPlaylists:(NSSet*)value_;
- (void)removePlaylists:(NSSet*)value_;
- (void)addPlaylistsObject:(SMKiTunesPlaylist*)value_;
- (void)removePlaylistsObject:(SMKiTunesPlaylist*)value_;

@end

@interface _SMKiTunesTrack (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveAlbumArtistName;
- (void)setPrimitiveAlbumArtistName:(NSString*)value;




- (NSString*)primitiveArtistName;
- (void)setPrimitiveArtistName:(NSString*)value;




- (NSData*)primitiveBookmark;
- (void)setPrimitiveBookmark:(NSData*)value;




- (NSNumber*)primitiveCompilation;
- (void)setPrimitiveCompilation:(NSNumber*)value;

- (BOOL)primitiveCompilationValue;
- (void)setPrimitiveCompilationValue:(BOOL)value_;




- (NSString*)primitiveComposer;
- (void)setPrimitiveComposer:(NSString*)value;




- (NSDate*)primitiveDateAdded;
- (void)setPrimitiveDateAdded:(NSDate*)value;




- (NSDate*)primitiveDateModified;
- (void)setPrimitiveDateModified:(NSDate*)value;




- (NSNumber*)primitiveDiscNumber;
- (void)setPrimitiveDiscNumber:(NSNumber*)value;

- (int32_t)primitiveDiscNumberValue;
- (void)setPrimitiveDiscNumberValue:(int32_t)value_;




- (NSNumber*)primitiveDuration;
- (void)setPrimitiveDuration:(NSNumber*)value;

- (int64_t)primitiveDurationValue;
- (void)setPrimitiveDurationValue:(int64_t)value_;




- (NSString*)primitiveGenre;
- (void)setPrimitiveGenre:(NSString*)value;




- (NSNumber*)primitiveIsClean;
- (void)setPrimitiveIsClean:(NSNumber*)value;

- (BOOL)primitiveIsCleanValue;
- (void)setPrimitiveIsCleanValue:(BOOL)value_;




- (NSNumber*)primitiveIsExplicit;
- (void)setPrimitiveIsExplicit:(NSNumber*)value;

- (BOOL)primitiveIsExplicitValue;
- (void)setPrimitiveIsExplicitValue:(BOOL)value_;




- (NSNumber*)primitiveRating;
- (void)setPrimitiveRating:(NSNumber*)value;

- (int32_t)primitiveRatingValue;
- (void)setPrimitiveRatingValue:(int32_t)value_;




- (NSNumber*)primitiveTrackNumber;
- (void)setPrimitiveTrackNumber:(NSNumber*)value;

- (int32_t)primitiveTrackNumberValue;
- (void)setPrimitiveTrackNumberValue:(int32_t)value_;





- (SMKiTunesAlbum*)primitiveAlbum;
- (void)setPrimitiveAlbum:(SMKiTunesAlbum*)value;



- (NSMutableSet*)primitivePlaylists;
- (void)setPrimitivePlaylists:(NSMutableSet*)value;


@end
