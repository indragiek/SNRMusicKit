// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SNRITunesAlbum.m instead.

#import "_SNRITunesAlbum.h"

const struct SNRITunesAlbumAttributes SNRITunesAlbumAttributes = {
};

const struct SNRITunesAlbumRelationships SNRITunesAlbumRelationships = {
	.artist = @"artist",
	.tracks = @"tracks",
};

const struct SNRITunesAlbumFetchedProperties SNRITunesAlbumFetchedProperties = {
};

@implementation SNRITunesAlbumID
@end

@implementation _SNRITunesAlbum

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SNRiTunesAlbum" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SNRiTunesAlbum";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SNRiTunesAlbum" inManagedObjectContext:moc_];
}

- (SNRITunesAlbumID*)objectID {
	return (SNRITunesAlbumID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
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
