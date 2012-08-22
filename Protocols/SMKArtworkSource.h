//
//  SMKArtworkSource.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-21.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SMKArtworkSource <NSObject>
@optional
/**
 @return URL to retrieve the small artwork image from
 @discussion This could be a local or remote URL.
 */
- (NSURL *)smallArtworkURL;

/**
 @return URL to retrieve the large artwork image from
 @discussion This could be a local or remote URL.
 */
- (NSURL *)largeArtworkURL;
@end
