//
//  SMKContentSource.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-21.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SMKContentSource <NSObject>
@required
/**
 @return The name of the content source.
 */
- (NSString *)name;

/**
 @param error An NSError object with error information if it was unsuccessful.
 @return An array of objects conforming to the SMKPlaylist
 @discussion This method is synchronous, and will block until the playlists have been fetched.
 */
- (NSArray *)playlistsWithError:(NSError **)error;

/**
 This method will fetch the playlists asynchronously and call the completion handler when finished.
 @discussion This method is asynchronous and will return immediately.
 */
- (void)fetchPlaylistsWithCompletionHandler:(void(^)(NSArray *playlists, NSError *error))handler;
@end
