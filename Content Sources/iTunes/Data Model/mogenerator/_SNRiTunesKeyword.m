// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SNRiTunesKeyword.m instead.

#import "_SNRiTunesKeyword.h"

const struct SNRiTunesKeywordAttributes SNRiTunesKeywordAttributes = {
	.name = @"name",
};

const struct SNRiTunesKeywordRelationships SNRiTunesKeywordRelationships = {
	.objects = @"objects",
};

const struct SNRiTunesKeywordFetchedProperties SNRiTunesKeywordFetchedProperties = {
};

@implementation SNRiTunesKeywordID
@end

@implementation _SNRiTunesKeyword

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SNRiTunesKeyword" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SNRiTunesKeyword";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SNRiTunesKeyword" inManagedObjectContext:moc_];
}

- (SNRiTunesKeywordID*)objectID {
	return (SNRiTunesKeywordID*)[super objectID];
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
