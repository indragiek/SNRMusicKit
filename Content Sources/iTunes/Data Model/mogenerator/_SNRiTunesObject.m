// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SNRiTunesObject.m instead.

#import "_SNRiTunesObject.h"

const struct SNRiTunesObjectAttributes SNRiTunesObjectAttributes = {
	.identifier = @"identifier",
	.name = @"name",
};

const struct SNRiTunesObjectRelationships SNRiTunesObjectRelationships = {
	.keywords = @"keywords",
};

const struct SNRiTunesObjectFetchedProperties SNRiTunesObjectFetchedProperties = {
};

@implementation SNRiTunesObjectID
@end

@implementation _SNRiTunesObject

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SNRiTunesObject" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SNRiTunesObject";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SNRiTunesObject" inManagedObjectContext:moc_];
}

- (SNRiTunesObjectID*)objectID {
	return (SNRiTunesObjectID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic identifier;






@dynamic name;






@dynamic keywords;

	
- (NSMutableSet*)keywordsSet {
	[self willAccessValueForKey:@"keywords"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"keywords"];
  
	[self didAccessValueForKey:@"keywords"];
	return result;
}
	






@end
