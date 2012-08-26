//
//  SMKArtworkCache.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-25.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SMKArtworkCache.h"

static NSString *_imageCacheDirectory;

@implementation SMKArtworkCache {
    dispatch_queue_t _diskOperationQueue;
}

+ (instancetype)sharedCache
{
    static dispatch_once_t pred;
    static SMKArtworkCache *sharedCache;
    dispatch_once(&pred, ^{
        sharedCache = [[SMKArtworkCache alloc] init];
    });
    return sharedCache;
}

- (id)init
{
    if ((self = [super init])) {
        self.JPEGCompressionQuality = 1.0;
        _diskOperationQueue = dispatch_queue_create("com.indragie.SNRMusicKit.artworkDiskOperationQueue", DISPATCH_QUEUE_CONCURRENT);
        [[NSFileManager defaultManager] createDirectoryAtPath:[self _imageCacheDirectory] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return self;
}

- (void)dealloc
{
    dispatch_release(_diskOperationQueue);
}

#pragma mark - Public API

- (void)fetchImageForKey:(NSString *)key completionHandler:(void (^)(SMKPlatformNativeImage *image))handler
{
    
}

- (void)setCachedImage:(SMKPlatformNativeImage *)image forKey:(NSString *)key
{
    
}

- (void)removeCachedImageForKey:(NSString *)key
{
    
}

#pragma mark - Private

- (void)_writeImageToDisk:(SMKPlatformNativeImage *)image withKey:(NSString *)key
{
    __weak SMKArtworkCache *weakSelf = self;
    dispatch_async(_diskOperationQueue, ^{
        SMKArtworkCache *strongSelf = weakSelf;
        NSData *data = SMKImageJPEGRepresentation(image, strongSelf.JPEGCompressionQuality);
        [data writeToFile:[strongSelf _cachePathForKey:key] atomically:YES];
    });
}

- (void)_removeAllImagesOnDisk
{
    
}

- (NSString *)_imageCacheDirectory
{
    if (!_imageCacheDirectory) {
        _imageCacheDirectory = [[NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/SMKArtworkCache"] copy];
    }
    return _imageCacheDirectory;
}

- (NSString *)_cachePathForKey:(NSString *)key
{
    NSString *fileName = [NSString stringWithFormat:@"%lu", [key hash]];
    return [[self _imageCacheDirectory] stringByAppendingPathComponent:fileName];
}
@end
