//
//  SMKArtist.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-21.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMKContentObject.h"
#import "SMKArtworkSource.h"
#import "SMKWebObject.h"

@protocol SMKArtist <NSObject, SMKContentObject, SMKArtworkSource, SMKWebObject>
@required
/**
@param error An NSError object with error information if it was unsuccessful.
 @return An array of objects conforming to the SMKAlbum protocol.
 @discussion This method is synchronous, and will block until the albums have been fetched.
 */
- (NSArray *)albumsWithError:(NSError **)error;

/**
 This method will fetch the albums asynchronously and call the completion handler when finished.
 @discussion This method is asynchronous and will return immediately.
*/
- (void)fetchAlbumsWithCompletionHandler:(void(^)(NSArray *albums, NSError *error))handler;

@optional
/**
 @return The number of tracks that the artist has.
*/
- (NSUInteger)numberOfTracks;
@end
