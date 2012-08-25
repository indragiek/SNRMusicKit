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
#import "SMKWebObject.h"

@protocol SMKTrack <NSObject, SMKContentObject, SMKWebObject>
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
- (NSNumber *)duration;

/**
 @return The URL to play the track from
 @discussion This URL could be local or remote (for streaming services). If the track cannot be played, this method should return nil.
 */
- (NSURL *)playbackURL;

@optional

/**
 @return The composer of the track.
 */
- (NSString *)composer;

/**
 @return The track's track number.
 */
- (NSNumber *)trackNumber;

/**
 @return The track's disc number.
*/
- (NSNumber *)discNumber;

/**
 @return The number of times the track has been played.
 */
- (NSNumber *)playCounts;

/**
 @return The popularity index for the track.
 @discussion This value can have different scales depending on the content source,
 but in general, a higher popularity index means the track is more popular. If this
 information is not available, this method will return 0.
*/
- (NSNumber *)popularity;

/**
 @return Whether the track contains explicit content.
 */
- (NSNumber *)isExplicit;

/**
 @return Whether the track is free of explicit content.
 */
- (NSNumber *)isClean;

/**
 Plays the tracks
 @return Whether the track was successfully played.
 @param error An NSError object with error information if it was unsuccessful.
 */
- (BOOL)playWithError:(NSError **)error;
@end
