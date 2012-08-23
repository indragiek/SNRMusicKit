//
//  SMKiTunesSyncOperation.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-22.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SMKiTunesSyncOperation.h"
#import "SMKiTunesConstants.h"
#import "SMKiTunesContentSource.h"
#import "SMKiTunesTrack.h"
#import "SMKiTunesArtist.h"
#import "SMKiTunesAlbum.h"
#import "SMKiTunesPlaylist.h"

#import "NSManagedObjectContext+SMKAdditions.h"
#import "NSManagedObjectContext+SMKiTunesAdditions.h"

// The context will be saved after importing this many tracks
static NSUInteger const SMKiTunesSyncOperationSaveEvery = 200;

@interface SMKiTunesSyncOperation ()
- (NSURL *)_iTunesLibraryURL;
- (void)_createBackgroundContext;

- (NSArray*)_iTunesTracksNewOnly:(BOOL)new;
- (NSArray *)_existingiTunesTrackPersistentIDs;

- (BOOL)_validateiTunesTrackDictionary:(NSDictionary *)dictionary;
- (BOOL)_validateiTunesPlaylistDictionary:(NSDictionary *)dictionary;
- (SMKiTunesTrack *)_importiTunesFileWithDictionary:(NSDictionary *)dictionary error:(NSError **)error;
- (void)_removeDeadiTunesTracks;
- (void)_removeAllPlaylists;

- (void)_managedObjectContextDidSave:(NSNotification *)notification;
@end

@implementation SMKiTunesSyncOperation {
    NSDictionary *_iTunesDictionary;
    NSManagedObjectContext *_context;
    
    NSArray *_existingiTunesTrackPersistentIDs;
    NSMutableArray *_removediTunesTrackPersistentIDs;
}
@synthesize contentSource = _contentSource;
@synthesize progressBlock = _progressBlock;
@synthesize completionBlock = _completionBlock;

- (id)init
{
    if ((self = [super init])) {
        NSURL *libraryURL = [self _iTunesLibraryURL];
        if (!libraryURL) { return nil; }
        NSError *error = nil;
        _iTunesDictionary = [NSPropertyListSerialization propertyListWithData:[NSData dataWithContentsOfURL:libraryURL] options:NSPropertyListImmutable format:NULL error:&error];
        if (error) {
            NSLog(@"Error reading iTunes Music Library.xml: %@, %@", error, [error userInfo]);
        }
    }
    return self;
}

- (void)main
{
    [self _createBackgroundContext];
    _existingiTunesTrackPersistentIDs = [self _existingiTunesTrackPersistentIDs];
    // Check if stuff has been imported already to decide whether to only import new tracks
    BOOL importNew = ([_existingiTunesTrackPersistentIDs count] != 0);
    NSArray *tracks = [self _iTunesTracksNewOnly:importNew];
    NSUInteger totalTracks = [tracks count];
    [_context performBlockAndWait:^{
        NSUInteger saveCount = 0;
        NSUInteger importedCount = 0;
        
        // After importing the tracks, we need to create playlists
        // iTunes has this one big master playlist called "Music" containing all the audio files in the library
        // During the playlist creation procedure, we find SMKiTunesTrack objects that correspond to the track ID
        // in the playlist dictionary by fetching with a predicate. This would get extremely expensive for the Music
        // playlist since it has everything in the library. Therefore, if we're importing all music
        // (and not just syncing new tracks), we do a little bit of optimization by building the array
        // beforehand so it can just be set on the Music playlist without all the fetching.
        
        NSMutableArray *music = nil;
        if (!importNew)
            music = [NSMutableArray arrayWithCapacity:totalTracks];
        for (NSDictionary *trackDict in tracks) {
            @autoreleasepool {
                NSError *error = nil;
                SMKiTunesTrack *track = [self _importiTunesFileWithDictionary:trackDict error:&error];
                //NSLog(@"Imported track %@", track.name);
                if (error)
                    NSLog(@"Error importing track: %@, %@", error, [error userInfo]);
                if (track)
                    [music addObject:track];
                if (self.progressBlock) {
                    self.progressBlock(self, importedCount, totalTracks, error);
                }
                saveCount++;
                importedCount++;
                // We don't want tons of objects being allocated
                // so we save and clear the context every few hundred objects
                if (saveCount == SMKiTunesSyncOperationSaveEvery) {
                    [_context SMK_saveChanges];
                    saveCount = 0;
                }
            }
        }
        // Remove all the dead objects that no longer exist in iTunes
        [self _removeDeadiTunesTracks];
        // Remove all the playlists (since we're going to refresh them anyways)
        [self _removeAllPlaylists];
        // Refresh all the playlist content
        NSArray *playlists = [_iTunesDictionary valueForKey:SMKiTunesKeyPlaylists];
        NSDictionary *tracks = [_iTunesDictionary valueForKey:SMKiTunesKeyTracks];
        // Iterate through all the playlists
        for (NSDictionary *playlist in playlists) {
            @autoreleasepool {
                if (![self _validateiTunesPlaylistDictionary:playlist]) { continue; }
                // Create a new playlist object for each dictionary
                NSString *name = [playlist valueForKey:SMKiTunesKeyName];
                SMKiTunesPlaylist *iTunesPlaylist = [_context SMK_createObjectOfEntityName:SMKiTunesEntityNamePlaylist];
                [iTunesPlaylist setName:name];
                // If we're already imported the entire music playlist, then just set those objects
                // without any additional fetching
                if (!importNew && [[playlist valueForKey:SMKiTunesKeyMusic] boolValue]) {
                    [iTunesPlaylist setTracks:[NSOrderedSet orderedSetWithArray:music]];
                    music = nil;
                } else {
                    // Otherwise each track needs to be fetched individually by persistent ID
                    NSArray *items = [playlist valueForKey:SMKiTunesKeyPlaylistItems];
                    NSMutableOrderedSet *playlistTracks = [[NSMutableOrderedSet alloc] initWithCapacity:[items count]];
                    for (NSDictionary *item in items) {
                        NSNumber *trackID = [item valueForKey:SMKiTunesKeyTrackID];
                        NSDictionary *trackDict = [tracks objectForKey:[trackID stringValue]];
                        NSString *persistentID = [trackDict valueForKey:SMKiTunesKeyPersistentID];
                        SMKiTunesTrack *track = [_context SMK_iTunesTrackWithIdentifier:persistentID];
                        if (track)
                            [playlistTracks addObject:track];
                    }
                    [iTunesPlaylist setTracks:playlistTracks];
                }
            }
        }
        [_context SMK_saveChanges];
        [_context reset];
    }];
    if (self.completionBlock) {
        self.completionBlock(self, totalTracks);
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Private

- (void)_createBackgroundContext
{
    _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    NSPersistentStoreCoordinator *persistentStoreCoordinator = [self.contentSource persistentStoreCoordinator];
    [_context performBlockAndWait:^{
        [_context setPersistentStoreCoordinator:persistentStoreCoordinator];
        [_context setMergePolicy:[[NSMergePolicy alloc] initWithMergeType:NSOverwriteMergePolicyType]];
        [_context setUndoManager:nil];
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_managedObjectContextDidSave:) name:NSManagedObjectContextObjectsDidChangeNotification object:_context];
}

#pragma mark - Notifications

// Merge the objects from the background context back into the main context
- (void)_managedObjectContextDidSave:(NSNotification *)notification
{
    NSManagedObjectContext *mainContext = [self.contentSource mainQueueObjectContext];
    NSManagedObjectContext *backgroundContext = [self.contentSource backgroundQueueObjectContext];
    [mainContext performBlock:^{
        [mainContext mergeChangesFromContextDidSaveNotification:notification];
    }];
    [backgroundContext performBlock:^{
        [backgroundContext mergeChangesFromContextDidSaveNotification:notification];
    }];
}

#pragma mark - iTunes Library Parsing

// Useful tidbit from iMediaBrowser <https://github.com/karelia/iMedia>
// Returns the path to the iTunes Music Library

- (NSURL *)_iTunesLibraryURL
{
    NSArray *libraryDatabases = [[[NSUserDefaults standardUserDefaults] persistentDomainForName:@"com.apple.iApps"] objectForKey:@"iTunesRecentDatabases"];
    return (([libraryDatabases count])) ? [NSURL URLWithString:[libraryDatabases objectAtIndex:0]] : nil;
}

// Parses through the iTunes dictionary and builds an array
// of all the songs in the library

- (NSArray*)_iTunesTracksNewOnly:(BOOL)new
{
    NSArray *playlists = [_iTunesDictionary valueForKey:SMKiTunesKeyPlaylists];
    NSDictionary *tracks = [_iTunesDictionary valueForKey:SMKiTunesKeyTracks];
    if (new)
        _removediTunesTrackPersistentIDs = [_existingiTunesTrackPersistentIDs mutableCopy];
    NSMutableArray *songs = [NSMutableArray array];
    for (NSDictionary *playlist in playlists) {
        NSNumber *music = [playlist valueForKey:SMKiTunesKeyMusic];
        // Locate the Music playlist (we don't want Podcasts and Videos and the rest of the content types
        // that make up the cluttered behemoth known as iTunes)
        if ([music boolValue]) {
            NSArray *items = [playlist valueForKey:SMKiTunesKeyPlaylistItems];
            for (NSDictionary *item in items) {
                NSNumber *trackID = [item valueForKey:SMKiTunesKeyTrackID];
                NSDictionary *track = [tracks objectForKey:[trackID stringValue]];
                // Skip the track if validation fails (usually if it's a remote file or has video content)
                if (![self _validateiTunesTrackDictionary:track]) { continue; }
                if (new) {
                    // If we're only checking new tracks, check the persistent ID of the track
                    // and see if it already exists in our database
                    NSString *persistentID = [track valueForKey:SMKiTunesKeyPersistentID];
                    NSUInteger index = [_existingiTunesTrackPersistentIDs indexOfObject:persistentID];
                    if (persistentID) {
                        if (index == NSNotFound) {
                            [songs addObject:track];
                        } else {
                            // "Cross off" the tracks that are in the iTunes dictionary
                            // one by one as we process them. What's left in the array
                            // are the tracks that no longer exist in iTunes and therefore
                            // should no longer exist in this database either
                            [_removediTunesTrackPersistentIDs removeObject:persistentID];
                        }
                    }
                } else {
                    [songs addObject:track];
                }
            }
        }
    }
    return songs;
}

// Returns an array of all the persistent ID's that already exist in the database
// Hence, we can use this to sift out the iTunes tracks that are already cached

- (NSArray *)_existingiTunesTrackPersistentIDs
{
    static NSString* persistentIDKey = @"identifier";
    NSMutableArray *results = [NSMutableArray array];
    [_context performBlockAndWait:^{
        NSFetchRequest *trackRequest = [NSFetchRequest fetchRequestWithEntityName:SMKiTunesEntityNameTrack];
        [trackRequest setResultType:NSDictionaryResultType];
        [trackRequest setPropertiesToFetch:@[persistentIDKey]];
        NSError *error = nil;
        [results addObjectsFromArray:[_context executeFetchRequest:trackRequest error:&error]];
        if (error)
            NSLog(@"Error fetching iTunes persistent ID's for tracks: %@, %@", error, [error userInfo]);
    }];
    return [results valueForKey:persistentIDKey];
}

// Validate the iTunes dictionary by checking for unwanted attributes
// such as the file being remote, or containing video

- (BOOL)_validateiTunesTrackDictionary:(NSDictionary *)dictionary
{
    return [[dictionary valueForKey:SMKiTunesKeyTrackType] isEqualToString:SMKiTunesKeyValueFileTrackType] && ![[dictionary valueForKey:SMKiTunesKeyHasVideo] boolValue];
}

// Create SNRiTunesTrack objects with the info from the dictionary
- (SMKiTunesTrack *)_importiTunesFileWithDictionary:(NSDictionary *)dictionary error:(NSError **)error
{
    SMKiTunesTrack *track = [_context SMK_createObjectOfEntityName:SMKiTunesEntityNameTrack];
    NSURL *url = [NSURL URLWithString:[dictionary valueForKey:SMKiTunesKeyLocation]];
    NSData *bookmarkData = [url bookmarkDataWithOptions:NSURLBookmarkCreationMinimalBookmark includingResourceValuesForKeys:nil relativeToURL:nil error:error];
    if (!bookmarkData) {
        [_context deleteObject:track];
        return nil;
    }
    [track setBookmark:bookmarkData];
    NSString *name = [dictionary valueForKey:SMKiTunesKeyName];
    [track setName:SMKObjectIsValid(name) ? name : SMKiTunesUntitledTrackName];
    [track setAlbumArtistName:[dictionary valueForKey:SMKiTunesKeyAlbumArtist]];
    [track setArtistName:[dictionary valueForKey:SMKiTunesKeyArtist]];
    [track setComposer:[dictionary valueForKey:SMKiTunesKeyComposer]];
    [track setTrackNumber:[dictionary valueForKey:SMKiTunesKeyTrackNumber]];
    [track setDiscNumber:[dictionary valueForKey:SMKiTunesKeyDiscNumber]];
    NSUInteger duration = [[dictionary valueForKey:SMKiTunesKeyTotalTime] unsignedIntegerValue];
    [track setDuration:@(duration / 1000)]; // Need to divide by 1000 because iTunes durations are in ms
    [track setIdentifier:[dictionary valueForKey:SMKiTunesKeyPersistentID]];
    NSString *albumTitle = [dictionary valueForKey:SMKiTunesKeyAlbum];
    NSString *artistName = SMKObjectIsValid([track albumArtistName]) ? [track albumArtistName] : [track artistName];
    NSNumber *compilation = [dictionary valueForKey:SMKiTunesKeyCompilation];
    SMKiTunesArtist *artist = [compilation boolValue] ? [_context SMK_iTunesCompilationsArtist] : [_context SMK_iTunesArtistWithName:artistName create:YES];
    SMKiTunesAlbum *album = [_context SMK_iTunesAlbumWithName:albumTitle byArtist:artist create:YES];
    [track setAlbum:album];
    if (![album isCompilation] && SMKObjectIsValid(compilation)) {
        [album setIsCompilation:compilation];
    }
    NSNumber *year = [dictionary valueForKey:SMKiTunesKeyYear];
    if (![album releaseYear] && SMKObjectIsValid(year)) {
        [album setReleaseYear:year];
    }
    return track;
}

// Removes all the tracks that no longer exist in the library
- (void)_removeDeadiTunesTracks
{
    for (NSString *identifier in _removediTunesTrackPersistentIDs) {
        if (!SMKObjectIsValid(identifier)) { continue; }
        SMKiTunesTrack *track = [_context SMK_iTunesTrackWithIdentifier:identifier];
        [_context deleteObject:track];
    }
    [_context SMK_saveChanges];
}

// Removes all the playlists 
- (void)_removeAllPlaylists
{
    NSError *error = nil;
    NSArray *playlists = [_context SMK_noBlockFetchWithEntityName:SMKiTunesEntityNamePlaylist sortDescriptors:nil predicate:nil batchSize:0 fetchLimit:0 error:&error];
    for (NSManagedObject *playlist in playlists) {
        [_context deleteObject:playlist];
    }
    [_context SMK_saveChanges];
}

- (BOOL)_validateiTunesPlaylistDictionary:(NSDictionary *)dictionary
{
    return ![dictionary valueForKey:SMKiTunesKeyMaster] && (![dictionary valueForKey:SMKiTunesKeyDistinguishedKind] || [[dictionary valueForKey:SMKiTunesKeyMusic] boolValue]) && ![[dictionary valueForKey:SMKiTunesKeyFolder] boolValue];
}
@end
