// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SMKiTunesTrack.m instead.

#import "_SMKiTunesTrack.h"

const struct SMKiTunesTrackAttributes SMKiTunesTrackAttributes = {
	.albumArtistName = @"albumArtistName",
	.artistName = @"artistName",
	.bookmark = @"bookmark",
	.compilation = @"compilation",
	.composer = @"composer",
	.dateAdded = @"dateAdded",
	.dateModified = @"dateModified",
	.discNumber = @"discNumber",
	.duration = @"duration",
	.genre = @"genre",
	.isClean = @"isClean",
	.isExplicit = @"isExplicit",
	.rating = @"rating",
	.trackNumber = @"trackNumber",
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
	
	if ([key isEqualToString:@"compilationValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"compilation"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"discNumberValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"discNumber"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"durationValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"duration"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"isCleanValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isClean"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"isExplicitValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isExplicit"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"ratingValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"rating"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"trackNumberValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"trackNumber"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic albumArtistName;






@dynamic artistName;






@dynamic bookmark;






@dynamic compilation;



- (BOOL)compilationValue {
	NSNumber *result = [self compilation];
	return [result boolValue];
}

- (void)setCompilationValue:(BOOL)value_ {
	[self setCompilation:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveCompilationValue {
	NSNumber *result = [self primitiveCompilation];
	return [result boolValue];
}

- (void)setPrimitiveCompilationValue:(BOOL)value_ {
	[self setPrimitiveCompilation:[NSNumber numberWithBool:value_]];
}





@dynamic composer;






@dynamic dateAdded;






@dynamic dateModified;






@dynamic discNumber;



- (int32_t)discNumberValue {
	NSNumber *result = [self discNumber];
	return [result intValue];
}

- (void)setDiscNumberValue:(int32_t)value_ {
	[self setDiscNumber:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveDiscNumberValue {
	NSNumber *result = [self primitiveDiscNumber];
	return [result intValue];
}

- (void)setPrimitiveDiscNumberValue:(int32_t)value_ {
	[self setPrimitiveDiscNumber:[NSNumber numberWithInt:value_]];
}





@dynamic duration;



- (int64_t)durationValue {
	NSNumber *result = [self duration];
	return [result longLongValue];
}

- (void)setDurationValue:(int64_t)value_ {
	[self setDuration:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveDurationValue {
	NSNumber *result = [self primitiveDuration];
	return [result longLongValue];
}

- (void)setPrimitiveDurationValue:(int64_t)value_ {
	[self setPrimitiveDuration:[NSNumber numberWithLongLong:value_]];
}





@dynamic genre;






@dynamic isClean;



- (BOOL)isCleanValue {
	NSNumber *result = [self isClean];
	return [result boolValue];
}

- (void)setIsCleanValue:(BOOL)value_ {
	[self setIsClean:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveIsCleanValue {
	NSNumber *result = [self primitiveIsClean];
	return [result boolValue];
}

- (void)setPrimitiveIsCleanValue:(BOOL)value_ {
	[self setPrimitiveIsClean:[NSNumber numberWithBool:value_]];
}





@dynamic isExplicit;



- (BOOL)isExplicitValue {
	NSNumber *result = [self isExplicit];
	return [result boolValue];
}

- (void)setIsExplicitValue:(BOOL)value_ {
	[self setIsExplicit:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveIsExplicitValue {
	NSNumber *result = [self primitiveIsExplicit];
	return [result boolValue];
}

- (void)setPrimitiveIsExplicitValue:(BOOL)value_ {
	[self setPrimitiveIsExplicit:[NSNumber numberWithBool:value_]];
}





@dynamic rating;



- (int32_t)ratingValue {
	NSNumber *result = [self rating];
	return [result intValue];
}

- (void)setRatingValue:(int32_t)value_ {
	[self setRating:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveRatingValue {
	NSNumber *result = [self primitiveRating];
	return [result intValue];
}

- (void)setPrimitiveRatingValue:(int32_t)value_ {
	[self setPrimitiveRating:[NSNumber numberWithInt:value_]];
}





@dynamic trackNumber;



- (int32_t)trackNumberValue {
	NSNumber *result = [self trackNumber];
	return [result intValue];
}

- (void)setTrackNumberValue:(int32_t)value_ {
	[self setTrackNumber:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveTrackNumberValue {
	NSNumber *result = [self primitiveTrackNumber];
	return [result intValue];
}

- (void)setPrimitiveTrackNumberValue:(int32_t)value_ {
	[self setPrimitiveTrackNumber:[NSNumber numberWithInt:value_]];
}





@dynamic album;

	

@dynamic playlists;

	
- (NSMutableSet*)playlistsSet {
	[self willAccessValueForKey:@"playlists"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"playlists"];
  
	[self didAccessValueForKey:@"playlists"];
	return result;
}
	






@end
