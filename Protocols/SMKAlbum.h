//
//  SMKAlbum.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-21.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMKContentSource.h"
#import "SMKArtist.h"

@protocol SMKAlbum <NSObject>
@required
/*
 @return The name of the album
 */
- (NSString *)name;

/*
 @return The artist of the album
 */
- (id<SMKArtist>)artist;

/**
 @return The SMKContentSource object that this album was retrieved from.
 */
- (id<SMKContentSource>)contentSource;

/**
 @return an array of objects conforming to the SMKTrack protocol.
 @discussion This method is synchronous, and will block until the tracks have been fetched
 */
- (NSArray *)tracks;

/**
 This method will fetch the tracks asynchronously and call the completion handler when finished
 @discussion This method is asynchronous and will return immediately
 */
- (void)fetchTracksWithCompletionHandler:(void(^)(NSArray *tracks))handler;

/**
 @return A unique identifier string for the album
 */
- (NSString *)uniqueIdentifier;

@optional
/**
 @return The release date of the album.
 */
- (NSDate *)releaseDate;

/**
 @return The duration of the album in seconds.
 */
- (NSTimeInterval)duration;

/**
 @return URL to retrieve the thumbnail cover art image from.
 @discussion This could be a local or remote URL.
 */
- (NSURL *)smallCoverArtURL;

/**
 @return URL to retrieve the large cover art image from.
@discussion This could be a local or remote URL.
 */
- (NSURL *)largeCoverArtURL;

/**
 @return The URL to the content page for this album.
 */
- (NSURL *)webURL;

/**
 @return Whether the album is a compilation
 */
- (BOOL)isCompilation;

/**
 @return Whether the album contains explicit content.
 */
- (BOOL)isExplicit;

/**
 @return Whether the album is free of explicit content.
 */
- (BOOL)isClean;

/**
 @return Whether the album can be streamed from the content source.
 */
- (BOOL)canStream;
@end
