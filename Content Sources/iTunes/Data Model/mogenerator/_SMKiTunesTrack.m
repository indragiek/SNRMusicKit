// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SMKiTunesTrack.m instead.

#import "_SMKiTunesTrack.h"

const struct SMKiTunesTrackAttributes SMKiTunesTrackAttributes = {
	.albumArtistName = @"albumArtistName",
	.artistName = @"artistName",
	.bookmark = @"bookmark",
	.cd_compilation = @"cd_compilation",
	.cd_discNumber = @"cd_discNumber",
	.cd_duration = @"cd_duration",
	.cd_isClean = @"cd_isClean",
	.cd_isExplicit = @"cd_isExplicit",
	.cd_rating = @"cd_rating",
	.cd_trackNumber = @"cd_trackNumber",
	.composer = @"composer",
	.dateAdded = @"dateAdded",
	.dateModified = @"dateModified",
	.genre = @"genre",
};

const struct SMKiTunesTrackRelationships SMKiTunesTrackRelationships = {
	.album = @"album",
	.playlists = @"playlists",
};

const struct SMKiTunesTrackFetchedProperties SMKiTunesTrackFetchedProperties = {
};

@implementation SMKiTunesTrackID
@end

@implementation _SMKiTunesTrack

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SMKiTunesTrack" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SMKiTunesTrack";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SMKiTunesTrack" inManagedObjectContext:moc_];
}

- (SMKiTunesTrackID*)objectID {
	return (SMKiTunesTrackID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"cd_compilationValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"cd_compilation"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"cd_discNumberValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"cd_discNumber"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"cd_durationValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"cd_duration"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"cd_isCleanValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"cd_isClean"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"cd_isExplicitValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"cd_isExplicit"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"cd_ratingValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"cd_rating"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"cd_trackNumberValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"cd_trackNumber"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic albumArtistName;






@dynamic artistName;






@dynamic bookmark;






@dynamic cd_compilation;



- (BOOL)cd_compilationValue {
	NSNumber *result = [self cd_compilation];
	return [result boolValue];
}

- (void)setCd_compilationValue:(BOOL)value_ {
	[self setCd_compilation:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveCd_compilationValue {
	NSNumber *result = [self primitiveCd_compilation];
	return [result boolValue];
}

- (void)setPrimitiveCd_compilationValue:(BOOL)value_ {
	[self setPrimitiveCd_compilation:[NSNumber numberWithBool:value_]];
}





@dynamic cd_discNumber;



- (int32_t)cd_discNumberValue {
	NSNumber *result = [self cd_discNumber];
	return [result intValue];
}

- (void)setCd_discNumberValue:(int32_t)value_ {
	[self setCd_discNumber:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveCd_discNumberValue {
	NSNumber *result = [self primitiveCd_discNumber];
	return [result intValue];
}

- (void)setPrimitiveCd_discNumberValue:(int32_t)value_ {
	[self setPrimitiveCd_discNumber:[NSNumber numberWithInt:value_]];
}





@dynamic cd_duration;



- (float)cd_durationValue {
	NSNumber *result = [self cd_duration];
	return [result floatValue];
}

- (void)setCd_durationValue:(float)value_ {
	[self setCd_duration:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveCd_durationValue {
	NSNumber *result = [self primitiveCd_duration];
	return [result floatValue];
}

- (void)setPrimitiveCd_durationValue:(float)value_ {
	[self setPrimitiveCd_duration:[NSNumber numberWithFloat:value_]];
}





@dynamic cd_isClean;



- (BOOL)cd_isCleanValue {
	NSNumber *result = [self cd_isClean];
	return [result boolValue];
}

- (void)setCd_isCleanValue:(BOOL)value_ {
	[self setCd_isClean:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveCd_isCleanValue {
	NSNumber *result = [self primitiveCd_isClean];
	return [result boolValue];
}

- (void)setPrimitiveCd_isCleanValue:(BOOL)value_ {
	[self setPrimitiveCd_isClean:[NSNumber numberWithBool:value_]];
}





@dynamic cd_isExplicit;



- (BOOL)cd_isExplicitValue {
	NSNumber *result = [self cd_isExplicit];
	return [result boolValue];
}

- (void)setCd_isExplicitValue:(BOOL)value_ {
	[self setCd_isExplicit:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveCd_isExplicitValue {
	NSNumber *result = [self primitiveCd_isExplicit];
	return [result boolValue];
}

- (void)setPrimitiveCd_isExplicitValue:(BOOL)value_ {
	[self setPrimitiveCd_isExplicit:[NSNumber numberWithBool:value_]];
}





@dynamic cd_rating;



- (int32_t)cd_ratingValue {
	NSNumber *result = [self cd_rating];
	return [result intValue];
}

- (void)setCd_ratingValue:(int32_t)value_ {
	[self setCd_rating:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveCd_ratingValue {
	NSNumber *result = [self primitiveCd_rating];
	return [result intValue];
}

- (void)setPrimitiveCd_ratingValue:(int32_t)value_ {
	[self setPrimitiveCd_rating:[NSNumber numberWithInt:value_]];
}





@dynamic cd_trackNumber;



- (int32_t)cd_trackNumberValue {
	NSNumber *result = [self cd_trackNumber];
	return [result intValue];
}

- (void)setCd_trackNumberValue:(int32_t)value_ {
	[self setCd_trackNumber:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveCd_trackNumberValue {
	NSNumber *result = [self primitiveCd_trackNumber];
	return [result intValue];
}

- (void)setPrimitiveCd_trackNumberValue:(int32_t)value_ {
	[self setPrimitiveCd_trackNumber:[NSNumber numberWithInt:value_]];
}





@dynamic composer;






@dynamic dateAdded;






@dynamic dateModified;






@dynamic genre;






@dynamic album;

	

@dynamic playlists;

	
- (NSMutableSet*)playlistsSet {
	[self willAccessValueForKey:@"playlists"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"playlists"];
  
	[self didAccessValueForKey:@"playlists"];
	return result;
}
	






@end
