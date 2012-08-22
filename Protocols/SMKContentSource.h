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
 @return An array of objects conforming to the SMKAlbum protocol.
 @discussion This method is synchronous, and will block until the albums have been fetched.
 */
- (NSArray *)albums;

/**
 This method will fetch the albums asynchronously and call the completion handler when finished.
 @discussion This method is asynchronous and will return immediately.
 */
- (void)fetchAlbumsWithCompletionHandler:(void(^)(NSArray *albums, NSError *error))handler;
@end
