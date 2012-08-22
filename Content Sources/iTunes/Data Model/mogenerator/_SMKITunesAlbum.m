// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SMKITunesAlbum.m instead.

#import "_SMKITunesAlbum.h"

const struct SMKITunesAlbumAttributes SMKITunesAlbumAttributes = {
};

const struct SMKITunesAlbumRelationships SMKITunesAlbumRelationships = {
	.artist = @"artist",
	.tracks = @"tracks",
};

const struct SMKITunesAlbumFetchedProperties SMKITunesAlbumFetchedProperties = {
};

@implementation SMKITunesAlbumID
@end

@implementation _SMKITunesAlbum

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

- (SMKITunesAlbumID*)objectID {
	return (SMKITunesAlbumID*)[super objectID];
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
