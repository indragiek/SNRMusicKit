//
//  SMKArtworkObject.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-21.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMKPlatformImports.h"

enum {
    SMKArtworkSizeSmallest = 0,
    SMKArtworkSizeSmall = 1,
    SMKArtworkSizeLarge = 2,
    SMKArtworkSizeLargest = 3
};
typedef NSUInteger SMKArtworkSize;

@protocol SMKArtworkObject <NSObject>
@required
/**
 Fetches artwork asynchronously.
 @param size The artwork size. If artwork of the given size is not available, it will return the closest possible match.
 @param handler Completion block to be called when the image is fetched
 @return An artwork image
 @discussion This method is asynchronous and will return immediately
 */
- (void)fetchArtworkWithSize:(SMKArtworkSize)size completionHandler:(void(^)(SMKPlatformNativeImage *image, NSError *error))handler;

@optional
/**
 Fetches artwork asynchronously.
 @param targetSize The size of the image. If an image of this size is not available, the closest possible match will be returned.
 @param handler Completion block to be called when the image is fetched
 @return An artwork image
 @discussion This method is asynchronous and will return immediately
 */
- (void)fetchArtworkWithTargetSize:(CGSize)size completionHandler:(void(^)(SMKPlatformNativeImage *image, NSError *error))handler;
@end
