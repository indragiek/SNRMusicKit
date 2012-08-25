// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SMKiTunesAlbum.m instead.

#import "_SMKiTunesAlbum.h"

const struct SMKiTunesAlbumAttributes SMKiTunesAlbumAttributes = {
	.cd_isCompilation = @"cd_isCompilation",
	.cd_rating = @"cd_rating",
	.cd_releaseYear = @"cd_releaseYear",
};

const struct SMKiTunesAlbumRelationships SMKiTunesAlbumRelationships = {
	.artist = @"artist",
	.tracks = @"tracks",
};

const struct SMKiTunesAlbumFetchedProperties SMKiTunesAlbumFetchedProperties = {
};

@implementation SMKiTunesAlbumID
@end

@implementation _SMKiTunesAlbum

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SMKiTunesAlbum" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SMKiTunesAlbum";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SMKiTunesAlbum" inManagedObjectContext:moc_];
}

- (SMKiTunesAlbumID*)objectID {
	return (SMKiTunesAlbumID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"cd_isCompilationValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"cd_isCompilation"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"cd_ratingValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"cd_rating"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"cd_releaseYearValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"cd_releaseYear"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic cd_isCompilation;



- (BOOL)cd_isCompilationValue {
	NSNumber *result = [self cd_isCompilation];
	return [result boolValue];
}

- (void)setCd_isCompilationValue:(BOOL)value_ {
	[self setCd_isCompilation:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveCd_isCompilationValue {
	NSNumber *result = [self primitiveCd_isCompilation];
	return [result boolValue];
}

- (void)setPrimitiveCd_isCompilationValue:(BOOL)value_ {
	[self setPrimitiveCd_isCompilation:[NSNumber numberWithBool:value_]];
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





@dynamic cd_releaseYear;



- (int32_t)cd_releaseYearValue {
	NSNumber *result = [self cd_releaseYear];
	return [result intValue];
}

- (void)setCd_releaseYearValue:(int32_t)value_ {
	[self setCd_releaseYear:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveCd_releaseYearValue {
	NSNumber *result = [self primitiveCd_releaseYear];
	return [result intValue];
}

- (void)setPrimitiveCd_releaseYearValue:(int32_t)value_ {
	[self setPrimitiveCd_releaseYear:[NSNumber numberWithInt:value_]];
}





@dynamic artist;

	

@dynamic tracks;

	
- (NSMutableSet*)tracksSet {
	[self willAccessValueForKey:@"tracks"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"tracks"];
  
	[self didAccessValueForKey:@"tracks"];
	return result;
}
	






@end
