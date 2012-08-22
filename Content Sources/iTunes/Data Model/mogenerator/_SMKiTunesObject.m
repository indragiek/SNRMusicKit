// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SMKiTunesObject.m instead.

#import "_SMKiTunesObject.h"

const struct SMKiTunesObjectAttributes SMKiTunesObjectAttributes = {
	.identifier = @"identifier",
	.name = @"name",
};

const struct SMKiTunesObjectRelationships SMKiTunesObjectRelationships = {
	.keywords = @"keywords",
};

const struct SMKiTunesObjectFetchedProperties SMKiTunesObjectFetchedProperties = {
};

@implementation SMKiTunesObjectID
@end

@implementation _SMKiTunesObject

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SMKiTunesObject" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SMKiTunesObject";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SMKiTunesObject" inManagedObjectContext:moc_];
}

- (SMKiTunesObjectID*)objectID {
	return (SMKiTunesObjectID*)[super objectID];
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
