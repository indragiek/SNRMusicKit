// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SNRiTunesPlaylist.m instead.

#import "_SNRiTunesPlaylist.h"

const struct SNRiTunesPlaylistAttributes SNRiTunesPlaylistAttributes = {
};

const struct SNRiTunesPlaylistRelationships SNRiTunesPlaylistRelationships = {
	.tracks = @"tracks",
};

const struct SNRiTunesPlaylistFetchedProperties SNRiTunesPlaylistFetchedProperties = {
};

@implementation SNRiTunesPlaylistID
@end

@implementation _SNRiTunesPlaylist

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SNRiTunesPlaylist" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SNRiTunesPlaylist";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SNRiTunesPlaylist" inManagedObjectContext:moc_];
}

- (SNRiTunesPlaylistID*)objectID {
	return (SNRiTunesPlaylistID*)[super objectID];
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
