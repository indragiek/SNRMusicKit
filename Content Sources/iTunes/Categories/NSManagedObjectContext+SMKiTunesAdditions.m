//
//  NSManagedObjectContext+SMKiTunesAdditions.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-22.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "NSManagedObjectContext+SMKiTunesAdditions.h"
#import "NSManagedObjectContext+SMKAdditions.h"
#import "SMKiTunesConstants.h"

@implementation NSManagedObjectContext (SMKiTunesAdditions)
- (SMKiTunesArtist *)SMK_iTunesArtistWithName:(NSString *)name create:(BOOL)create
{
    if (!SMKObjectIsValid(name))
        name = SMKiTunesUntitledArtistName;
    NSString *normalizedName = [SMKiTunesArtist sortingNameForName:name];
    NSError *error = nil;
    NSArray *fetchedObjects = [self SMK_legacyFetchWithEntityName:SMKiTunesEntityNameArtist sortDescriptors:nil predicate:[NSPredicate predicateWithFormat:@"normalizedName == %@", normalizedName] batchSize:0 fetchLimit:1 error:&error];
    if (error)
        SMKGenericErrorLog([NSString stringWithFormat:@"Error fetching iTunes artist with name %@", name], error);
	if (![fetchedObjects count]) {
        if (create) {
            SMKiTunesArtist *artist = [self SMK_createObjectOfEntityName:SMKiTunesEntityNameArtist];
            [artist setName:name];
            return artist;
        }
        return nil;
	}
	return [fetchedObjects objectAtIndex:0];
}

- (SMKiTunesAlbum *)SMK_iTunesAlbumWithName:(NSString *)name byArtist:(SMKiTunesArtist *)artist create:(BOOL)create
{
    if (!SMKObjectIsValid(name))
        name = SMKiTunesUntitledAlbumName;
    NSString *normalizedName = [SMKiTunesAlbum sortingNameForName:name];
    NSError *error = nil;
    NSArray *fetchedObjects = [self SMK_legacyFetchWithEntityName:SMKiTunesEntityNameAlbum sortDescriptors:nil predicate:[NSPredicate predicateWithFormat:@"(normalizedName == %@) AND (artist == %@)", normalizedName, artist] batchSize:0 fetchLimit:1 error:&error];
    if (error)
        SMKGenericErrorLog([NSString stringWithFormat:@"Error fetching iTunes album with name %@", name], error);
	if (![fetchedObjects count]) {
        if (create) {
            SMKiTunesAlbum *album = [self SMK_createObjectOfEntityName:SMKiTunesEntityNameAlbum];
            [album setName:name];
            return album;
        }
        return nil;
	}
	return [fetchedObjects objectAtIndex:0];
}

- (SMKiTunesTrack *)SMK_iTunesTrackWithIdentifier:(NSString *)identifier
{
    NSError *error = nil;
    NSArray *fetchedObjects = [self SMK_legacyFetchWithEntityName:SMKiTunesEntityNameTrack sortDescriptors:nil predicate:[NSPredicate predicateWithFormat:@"identifier == %@", identifier] batchSize:0 fetchLimit:1 error:&error];
    if (error)
        SMKGenericErrorLog([NSString stringWithFormat:@"Error fetching iTunes track with identifier %@", identifier], error);
    return ([fetchedObjects count] != 0) ? [fetchedObjects objectAtIndex:0] : nil;
}

- (SMKiTunesPlaylist *)SMK_iTunesPlaylistWithIdentifier:(NSString *)identifier
{
    NSError *error = nil;
    NSArray *fetchedObjects = [self SMK_legacyFetchWithEntityName:SMKiTunesEntityNamePlaylist sortDescriptors:nil predicate:[NSPredicate predicateWithFormat:@"identifier == %@", identifier] batchSize:0 fetchLimit:1 error:&error];
    if (error)
        SMKGenericErrorLog([NSString stringWithFormat:@"Error fetching iTunes playlist with identifier %@", identifier], error);
    return ([fetchedObjects count] != 0) ? [fetchedObjects objectAtIndex:0] : nil;
}

- (SMKiTunesArtist *)SMK_iTunesCompilationsArtist
{
    return [self SMK_iTunesArtistWithName:SMKiTunesCompilationsArtistName create:YES];
}
@end
