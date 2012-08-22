// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SNRiTunesArtist.m instead.

#import "_SNRiTunesArtist.h"

const struct SNRiTunesArtistAttributes SNRiTunesArtistAttributes = {
};

const struct SNRiTunesArtistRelationships SNRiTunesArtistRelationships = {
	.albums = @"albums",
};

const struct SNRiTunesArtistFetchedProperties SNRiTunesArtistFetchedProperties = {
};

@implementation SNRiTunesArtistID
@end

@implementation _SNRiTunesArtist

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SNRiTunesArtist" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SNRiTunesArtist";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SNRiTunesArtist" inManagedObjectContext:moc_];
}

- (SNRiTunesArtistID*)objectID {
	return (SNRiTunesArtistID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic albums;

	
- (NSMutableSet*)albumsSet {
	[self willAccessValueForKey:@"albums"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"albums"];
  
	[self didAccessValueForKey:@"albums"];
	return result;
}
	






@end
