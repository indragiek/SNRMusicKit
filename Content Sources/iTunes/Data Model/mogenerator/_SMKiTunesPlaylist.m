// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SMKiTunesPlaylist.m instead.

#import "_SMKiTunesPlaylist.h"

const struct SMKiTunesPlaylistAttributes SMKiTunesPlaylistAttributes = {
};

const struct SMKiTunesPlaylistRelationships SMKiTunesPlaylistRelationships = {
	.tracks = @"tracks",
};

const struct SMKiTunesPlaylistFetchedProperties SMKiTunesPlaylistFetchedProperties = {
};

@implementation SMKiTunesPlaylistID
@end

@implementation _SMKiTunesPlaylist

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SMKiTunesPlaylist" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SMKiTunesPlaylist";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SMKiTunesPlaylist" inManagedObjectContext:moc_];
}

- (SMKiTunesPlaylistID*)objectID {
	return (SMKiTunesPlaylistID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic tracks;

	
- (NSMutableSet*)tracksSet {
	[self willAccessValueForKey:@"tracks"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"tracks"];
  
	[self didAccessValueForKey:@"tracks"];
	return result;
}
	






@end
