//
//  NSManagedObjectContext+SMKiTunesAdditions.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-22.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "SMKiTunesArtist.h"
#import "SMKiTunesAlbum.h"
#import "SMKiTunesTrack.h"
#import "SMKiTunesPlaylist.h"

@interface NSManagedObjectContext (SMKiTunesAdditions)
/**
 @param name The artist name
 @param create Whether to create the artist if it doesn't exist
 @return The SMKiTunesArtist object
 */
- (SMKiTunesArtist *)SMK_iTunesArtistWithName:(NSString *)name create:(BOOL)create;

/**
 @param name The album name
 @param artist The artist of the album
 @param create Whether to create the album if it doesn't exist
 @return The SMKiTunesAlbum object
 */
- (SMKiTunesAlbum *)SMK_iTunesAlbumWithName:(NSString *)name byArtist:(SMKiTunesArtist *)artist create:(BOOL)create;

/**
 @param identifier The iTunes Persistent ID of the track
 @return The SMKiTunesTrack object
 */
- (SMKiTunesTrack *)SMK_iTunesTrackWithIdentifier:(NSString *)identifier;

/**
 @param identifier THe iTunes Persistent ID of the playlist
 @return The SNRiTunesPlaylist object
 */
- (SMKiTunesPlaylist *)SMK_iTunesPlaylistWithIdentifier:(NSString *)identifier;

/**
 @return The shared compilations artist
 */
- (SMKiTunesArtist *)SMK_iTunesCompilationsArtist;
@end
