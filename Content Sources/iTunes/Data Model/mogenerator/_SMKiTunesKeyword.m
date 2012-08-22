// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SMKiTunesKeyword.m instead.

#import "_SMKiTunesKeyword.h"

const struct SMKiTunesKeywordAttributes SMKiTunesKeywordAttributes = {
	.name = @"name",
};

const struct SMKiTunesKeywordRelationships SMKiTunesKeywordRelationships = {
	.objects = @"objects",
};

const struct SMKiTunesKeywordFetchedProperties SMKiTunesKeywordFetchedProperties = {
};

@implementation SMKiTunesKeywordID
@end

@implementation _SMKiTunesKeyword

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SMKiTunesKeyword" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SMKiTunesKeyword";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SMKiTunesKeyword" inManagedObjectContext:moc_];
}

- (SMKiTunesKeywordID*)objectID {
	return (SMKiTunesKeywordID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic name;






@dynamic objects;

	
- (NSMutableSet*)objectsSet {
	[self willAccessValueForKey:@"objects"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"objects"];
  
	[self didAccessValueForKey:@"objects"];
	return result;
}
	






@end
