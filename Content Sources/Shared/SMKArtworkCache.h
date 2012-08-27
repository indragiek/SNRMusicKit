//
//  SMKArtworkCache.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-25.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMKPlatformImports.h"
#import "SMKPlatformNativeImage+SMKAdditions.h"

//
// Cross platform artwork cache that handles on disk and in memory caching
// This class is largely inspired by JMImageCache by Jake Marsh (who is incredibly awesome)
// <https://github.com/jakemarsh/JMImageCache>
//

@interface SMKArtworkCache : NSCache
/**
 @return The shared instance of SMKArtworkCache
 */
+ (instancetype)sharedCache;

/**
 Compression quality of the image, 1.0 being best quality and 0.0 being lowest.
 Default value is 1.0.
 */
@property (nonatomic, assign) CGFloat JPEGCompressionQuality;

/**
 Maximum size of the on disk cache, in MB
 Default maximum size is 200MB.
 */
@property (nonatomic, assign) NSUInteger maximumDiskCacheSize;
/**
 Asynchronously fetches a cached image and calls the completion handler
 @param key The cached image key
 @param handler Hander block called with the fetched image
 */
- (void)fetchImageForKey:(NSString *)key completionHandler:(void (^)(SMKPlatformNativeImage *image))handler;

/**
 Saves an image in the cache with the specified key
 @param key The key to save the cached image under
 @param targetSize The target size of the image to scale to. Pass CGSizeZero to keep the image at the original size. Do not apply scale factors to this size, as the scaling process will account for that.
 @param method The resizing method to use. Values are defined in SMKPlatformNativeImage+SMKAdditions.h
 @param image The image to save
 */
- (void)setCachedImage:(SMKPlatformNativeImage *)image
                forKey:(NSString *)key
            targetSize:(CGSize)targetSize
        resizingMethod:(SMKImageResizingMethod)method;

/**
 Removes the image with the specified key from the cache
 @param key The key of the image to remove from the cache
 */
- (void)removeCachedImageForKey:(NSString *)key;

/**
 Removes every image in the cache (including on disk)
 */
- (void)removeAllCachedImages;
@end
