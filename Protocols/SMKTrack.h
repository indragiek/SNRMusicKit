//
//  SMKTrack.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-21.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMKAlbum.h"
#import "SMKArtist.h"
#import "SMKContentSource.h"

#import "SMKContentObject.h"

@protocol SMKTrack <NSObject, SMKContentObject>
@required
/**
 @return The parent artist of the track.
 */
- (id<SMKArtist>)artist;

/**
 @return The parent album of the track.
 */
- (id<SMKAlbum>)album;

/**
 @return The name of the artist
 */
- (NSString *)artistName;

/**
 @return The name of the album artist
 */
- (NSString *)albumArtistName;

/**
 @return The duration of the track in seconds.
 */
- (NSTimeInterval)duration;

/**
 @return The player class used to play this track
 */
+ (Class)playerClass;

@optional

/**
 @return The URL to play the track from
 @discussion This URL could be local or remote (for streaming services). If the track cannot be played via a URL, this method should return nil.
 */
- (NSURL *)playbackURL;

/**
 @return The composer of the track.
 */
- (NSString *)composer;

/**
 @return The track's track number.
 */
- (NSUInteger)trackNumber;

/**
 @return The track's disc number.
*/
- (NSUInteger)discNumber;

/**
 @return The number of times the track has been played.
 */
- (NSUInteger)playCount;

/**
 @return The lyrics for the song.
 */
- (NSString *)lyrics;

/**
 @return The genre of the song.
 */
- (NSString *)genre;

/**
 @return The rating of the song
 */
- (NSUInteger)rating;

/**
 @return The last play date of the song.
*/
- (NSDate *)lastPlayedDate;

/**
 @return The popularity index for the track.
 @discussion This value can have different scales depending on the content source,
 but in general, a higher popularity index means the track is more popular. If this
 information is not available, this method will return 0.
*/
- (NSUInteger)popularity;

/**
 @return Whether the track contains explicit content.
 */
- (BOOL)isExplicit;

/**
 @return Whether the track is free of explicit content.
 */
- (BOOL)isClean;
@end
