// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SMKiTunesArtist.m instead.

#import "_SMKiTunesArtist.h"

const struct SMKiTunesArtistAttributes SMKiTunesArtistAttributes = {
};

const struct SMKiTunesArtistRelationships SMKiTunesArtistRelationships = {
	.albums = @"albums",
};

const struct SMKiTunesArtistFetchedProperties SMKiTunesArtistFetchedProperties = {
};

@implementation SMKiTunesArtistID
@end

@implementation _SMKiTunesArtist

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SMKiTunesArtist" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SMKiTunesArtist";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SMKiTunesArtist" inManagedObjectContext:moc_];
}

- (SMKiTunesArtistID*)objectID {
	return (SMKiTunesArtistID*)[super objectID];
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
