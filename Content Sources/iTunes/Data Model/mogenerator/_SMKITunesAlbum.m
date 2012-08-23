// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SMKiTunesAlbum.m instead.

#import "_SMKiTunesAlbum.h"

const struct SMKiTunesAlbumAttributes SMKiTunesAlbumAttributes = {
	.isCompilation = @"isCompilation",
	.rating = @"rating",
	.releaseYear = @"releaseYear",
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
	
	if ([key isEqualToString:@"isCompilationValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isCompilation"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"ratingValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"rating"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"releaseYearValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"releaseYear"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic isCompilation;



- (BOOL)isCompilationValue {
	NSNumber *result = [self isCompilation];
	return [result boolValue];
}

- (void)setIsCompilationValue:(BOOL)value_ {
	[self setIsCompilation:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveIsCompilationValue {
	NSNumber *result = [self primitiveIsCompilation];
	return [result boolValue];
}

- (void)setPrimitiveIsCompilationValue:(BOOL)value_ {
	[self setPrimitiveIsCompilation:[NSNumber numberWithBool:value_]];
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





@dynamic artist;

	

@dynamic tracks;

	
- (NSMutableSet*)tracksSet {
	[self willAccessValueForKey:@"tracks"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"tracks"];
  
	[self didAccessValueForKey:@"tracks"];
	return result;
}
	






@end
