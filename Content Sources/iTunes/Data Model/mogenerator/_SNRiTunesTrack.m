// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SNRiTunesTrack.m instead.

#import "_SNRiTunesTrack.h"

const struct SNRiTunesTrackAttributes SNRiTunesTrackAttributes = {
	.albumArtistName = @"albumArtistName",
	.artistName = @"artistName",
	.bookmark = @"bookmark",
	.compilation = @"compilation",
	.composer = @"composer",
	.dateAdded = @"dateAdded",
	.discNumber = @"discNumber",
	.discTotal = @"discTotal",
	.duration = @"duration",
	.lyrics = @"lyrics",
	.releaseYear = @"releaseYear",
	.trackNumber = @"trackNumber",
	.trackTotal = @"trackTotal",
};

const struct SNRiTunesTrackRelationships SNRiTunesTrackRelationships = {
	.album = @"album",
	.playlists = @"playlists",
};

const struct SNRiTunesTrackFetchedProperties SNRiTunesTrackFetchedProperties = {
};

@implementation SNRiTunesTrackID
@end

@implementation _SNRiTunesTrack

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SNRiTunesTrack" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SNRiTunesTrack";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SNRiTunesTrack" inManagedObjectContext:moc_];
}

- (SNRiTunesTrackID*)objectID {
	return (SNRiTunesTrackID*)[super objectID];
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
	if ([key isEqualToString:@"discTotalValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"discTotal"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"durationValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"duration"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"releaseYearValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"releaseYear"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"trackNumberValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"trackNumber"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"trackTotalValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"trackTotal"];
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





@dynamic discTotal;



- (int32_t)discTotalValue {
	NSNumber *result = [self discTotal];
	return [result intValue];
}

- (void)setDiscTotalValue:(int32_t)value_ {
	[self setDiscTotal:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveDiscTotalValue {
	NSNumber *result = [self primitiveDiscTotal];
	return [result intValue];
}

- (void)setPrimitiveDiscTotalValue:(int32_t)value_ {
	[self setPrimitiveDiscTotal:[NSNumber numberWithInt:value_]];
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





@dynamic lyrics;






@dynamic releaseYear;



- (int32_t)releaseYearValue {
	NSNumber *result = [self releaseYear];
	return [result intValue];
}

- (void)setReleaseYearValue:(int32_t)value_ {
	[self setReleaseYear:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveReleaseYearValue {
	NSNumber *result = [self primitiveReleaseYear];
	return [result intValue];
}

- (void)setPrimitiveReleaseYearValue:(int32_t)value_ {
	[self setPrimitiveReleaseYear:[NSNumber numberWithInt:value_]];
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





@dynamic trackTotal;



- (int32_t)trackTotalValue {
	NSNumber *result = [self trackTotal];
	return [result intValue];
}

- (void)setTrackTotalValue:(int32_t)value_ {
	[self setTrackTotal:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveTrackTotalValue {
	NSNumber *result = [self primitiveTrackTotal];
	return [result intValue];
}

- (void)setPrimitiveTrackTotalValue:(int32_t)value_ {
	[self setPrimitiveTrackTotal:[NSNumber numberWithInt:value_]];
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
