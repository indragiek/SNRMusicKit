// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SMKiTunesTrack.h instead.

#import <CoreData/CoreData.h>
#import "SMKiTunesObject.h"

extern const struct SMKiTunesTrackAttributes {
	__unsafe_unretained NSString *albumArtistName;
	__unsafe_unretained NSString *artistName;
	__unsafe_unretained NSString *bookmark;
	__unsafe_unretained NSString *cd_compilation;
	__unsafe_unretained NSString *cd_discNumber;
	__unsafe_unretained NSString *cd_duration;
	__unsafe_unretained NSString *cd_isClean;
	__unsafe_unretained NSString *cd_isExplicit;
	__unsafe_unretained NSString *cd_rating;
	__unsafe_unretained NSString *cd_trackNumber;
	__unsafe_unretained NSString *composer;
	__unsafe_unretained NSString *dateAdded;
	__unsafe_unretained NSString *dateModified;
	__unsafe_unretained NSString *genre;
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




@property (nonatomic, strong) NSNumber* cd_compilation;


@property BOOL cd_compilationValue;
- (BOOL)cd_compilationValue;
- (void)setCd_compilationValue:(BOOL)value_;

//- (BOOL)validateCd_compilation:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* cd_discNumber;


@property int32_t cd_discNumberValue;
- (int32_t)cd_discNumberValue;
- (void)setCd_discNumberValue:(int32_t)value_;

//- (BOOL)validateCd_discNumber:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* cd_duration;


@property float cd_durationValue;
- (float)cd_durationValue;
- (void)setCd_durationValue:(float)value_;

//- (BOOL)validateCd_duration:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* cd_isClean;


@property BOOL cd_isCleanValue;
- (BOOL)cd_isCleanValue;
- (void)setCd_isCleanValue:(BOOL)value_;

//- (BOOL)validateCd_isClean:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* cd_isExplicit;


@property BOOL cd_isExplicitValue;
- (BOOL)cd_isExplicitValue;
- (void)setCd_isExplicitValue:(BOOL)value_;

//- (BOOL)validateCd_isExplicit:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* cd_rating;


@property int32_t cd_ratingValue;
- (int32_t)cd_ratingValue;
- (void)setCd_ratingValue:(int32_t)value_;

//- (BOOL)validateCd_rating:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* cd_trackNumber;


@property int32_t cd_trackNumberValue;
- (int32_t)cd_trackNumberValue;
- (void)setCd_trackNumberValue:(int32_t)value_;

//- (BOOL)validateCd_trackNumber:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* composer;


//- (BOOL)validateComposer:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* dateAdded;


//- (BOOL)validateDateAdded:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* dateModified;


//- (BOOL)validateDateModified:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* genre;


//- (BOOL)validateGenre:(id*)value_ error:(NSError**)error_;





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




- (NSNumber*)primitiveCd_compilation;
- (void)setPrimitiveCd_compilation:(NSNumber*)value;

- (BOOL)primitiveCd_compilationValue;
- (void)setPrimitiveCd_compilationValue:(BOOL)value_;




- (NSNumber*)primitiveCd_discNumber;
- (void)setPrimitiveCd_discNumber:(NSNumber*)value;

- (int32_t)primitiveCd_discNumberValue;
- (void)setPrimitiveCd_discNumberValue:(int32_t)value_;




- (NSNumber*)primitiveCd_duration;
- (void)setPrimitiveCd_duration:(NSNumber*)value;

- (float)primitiveCd_durationValue;
- (void)setPrimitiveCd_durationValue:(float)value_;




- (NSNumber*)primitiveCd_isClean;
- (void)setPrimitiveCd_isClean:(NSNumber*)value;

- (BOOL)primitiveCd_isCleanValue;
- (void)setPrimitiveCd_isCleanValue:(BOOL)value_;




- (NSNumber*)primitiveCd_isExplicit;
- (void)setPrimitiveCd_isExplicit:(NSNumber*)value;

- (BOOL)primitiveCd_isExplicitValue;
- (void)setPrimitiveCd_isExplicitValue:(BOOL)value_;




- (NSNumber*)primitiveCd_rating;
- (void)setPrimitiveCd_rating:(NSNumber*)value;

- (int32_t)primitiveCd_ratingValue;
- (void)setPrimitiveCd_ratingValue:(int32_t)value_;




- (NSNumber*)primitiveCd_trackNumber;
- (void)setPrimitiveCd_trackNumber:(NSNumber*)value;

- (int32_t)primitiveCd_trackNumberValue;
- (void)setPrimitiveCd_trackNumberValue:(int32_t)value_;




- (NSString*)primitiveComposer;
- (void)setPrimitiveComposer:(NSString*)value;




- (NSDate*)primitiveDateAdded;
- (void)setPrimitiveDateAdded:(NSDate*)value;




- (NSDate*)primitiveDateModified;
- (void)setPrimitiveDateModified:(NSDate*)value;




- (NSString*)primitiveGenre;
- (void)setPrimitiveGenre:(NSString*)value;





- (SMKiTunesAlbum*)primitiveAlbum;
- (void)setPrimitiveAlbum:(SMKiTunesAlbum*)value;



- (NSMutableSet*)primitivePlaylists;
- (void)setPrimitivePlaylists:(NSMutableSet*)value;


@end
