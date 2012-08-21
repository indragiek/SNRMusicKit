//
//  SMKArtist.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-21.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SMKArtist <NSObject>
@required
/**
 @return The name of the artist.
 */
- (NSString *)name;

/**
 @return The SMKContentSource object that this album was retrieved from.
 */
- (id<SMKContentSource>)contentSource;

/**
 @return An array of objects conforming to the SMKAlbum protocol.
 @discussion This method is synchronous, and will block until the albums have been fetched.
 */
- (NSArray *)albums

/**
 This method will fetch the albums asynchronously and call the completion handler when finished.
 @discussion This method is asynchronous and will return immediately.
*/
- (void)fetchAlbumsWithCompletionHandler:(void(^)(NSArray *albums, NSError *error))handler;

/**
 @return A unique identifier string for the album.
*/
- (NSString *)uniqueIdentifier;


@optional
/**
 @return The number of tracks that the artist has.
*/
- (NSUInteger)numberOfTracks;

/**
 @return URL to retrieve the thumbnail artist art from.
 @discussion This could be a local or remote URL.
 */
- (NSURL *)smallArtworkURL;

/**
 @return URL to retrieve the large artist art from.
 @discussion This could be a local or remote URL.
 */
- (NSURL *)largeCoverArtURL;

/**
 @return The URL to the content page for this artist.
 */
- (NSURL *)webURL;
@end
