//
//  SMKArtworkCache.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-25.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SMKArtworkCache.h"
#import "SMKPlatformNativeImage+SMKAdditions.h"

static NSString *_imageCacheDirectory;

@interface SMKArtworkCache ()
@property (nonatomic, assign) NSUInteger cacheSize;
@end

@implementation SMKArtworkCache {
    dispatch_queue_t _inputQueue;
    dispatch_queue_t _outputQueue;
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
        self.JPEGCompressionQuality = 1.0; // Best quality
        self.maximumDiskCacheSize = 200; // MB
        _outputQueue = dispatch_queue_create("com.indragie.SNRMusicKit.artworkOutputQueue", DISPATCH_QUEUE_SERIAL);
        _inputQueue = dispatch_queue_create("com.indragie.SNRMusicKit.artworkInputQueue", DISPATCH_QUEUE_SERIAL);
        [[NSFileManager defaultManager] createDirectoryAtPath:[self _imageCacheDirectory] withIntermediateDirectories:YES attributes:nil error:nil];
        __weak SMKArtworkCache *weakSelf = self;
        dispatch_async(_inputQueue, ^{
            SMKArtworkCache *strongSelf = weakSelf;
            [strongSelf _pruneDiskCache];
        });
    }
    return self;
}

- (void)dealloc
{
    dispatch_release(_outputQueue);
    dispatch_release(_inputQueue);
}

#pragma mark - Public API

- (void)fetchImageForKey:(NSString *)key completionHandler:(void (^)(SMKPlatformNativeImage *image))handler
{
    __weak SMKArtworkCache *weakSelf = self;
    dispatch_async(_outputQueue, ^{
        SMKArtworkCache *strongSelf = weakSelf;
        SMKPlatformNativeImage *image = [strongSelf objectForKey:key];
        if (!image) {
            image = [strongSelf _onDiskImageForKey:key];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (handler) handler(image);
        });
    });
}

- (void)setCachedImage:(SMKPlatformNativeImage *)image
                forKey:(NSString *)key
            targetSize:(CGSize)targetSize
        resizingMethod:(SMKImageResizingMethod)method
{
    __weak SMKArtworkCache *weakSelf = self;
    dispatch_async(_inputQueue, ^{
        SMKArtworkCache *strongSelf = weakSelf;
        SMKPlatformNativeImage *cacheImage = image;
        if (CGSizeEqualToSize(targetSize, CGSizeZero)) {
            cacheImage = [image imageToFitSize:targetSize method:method];
        }
        [strongSelf setObject:cacheImage forKey:key];
        [strongSelf _writeImageToDisk:cacheImage withKey:key];
    });
}

- (void)removeCachedImageForKey:(NSString *)key
{
    __weak SMKArtworkCache *weakSelf = self;
    dispatch_async(_inputQueue, ^{
        SMKArtworkCache *strongSelf = weakSelf;
        [strongSelf removeObjectForKey:key];
        [strongSelf _removeOnDiskImageForKey:key];
    });
}

- (void)removeAllCachedImages
{
    __weak SMKArtworkCache *weakSelf = self;
    dispatch_async(_inputQueue, ^{
        SMKArtworkCache *strongSelf = weakSelf;
        [strongSelf removeAllObjects];
        [strongSelf _removeAllImagesOnDisk];
    });
}

#pragma mark - Private

- (void)_writeImageToDisk:(SMKPlatformNativeImage *)image withKey:(NSString *)key
{
    NSData *data = SMKImageJPEGRepresentation(image, self.JPEGCompressionQuality);
    [data writeToFile:[self _cachePathForKey:key] atomically:YES];
}

- (SMKPlatformNativeImage*)_onDiskImageForKey:(NSString *)key
{
    NSData *data = [NSData dataWithContentsOfFile:[self _cachePathForKey:key]];
    if (data)
        return [[SMKPlatformNativeImage alloc] initWithData:data];
    return nil;
}

- (void)_removeOnDiskImageForKey:(NSString *)key
{
    [[NSFileManager new] removeItemAtPath:[self _cachePathForKey:key] error:nil];
}

- (void)_removeAllImagesOnDisk
{
    NSString *cachePath = [self _imageCacheDirectory];
    NSFileManager *fm = [NSFileManager new];
    [fm removeItemAtPath:cachePath error:nil];
    [fm createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:nil error:nil];
}

- (NSString *)_imageCacheDirectory
{
    if (!_imageCacheDirectory) {
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);

	    if ((nil == paths) || (0 == paths.count)) {
			return nil;
	    }

	    _imageCacheDirectory = [paths lastObject];
        _imageCacheDirectory = [[_imageCacheDirectory stringByAppendingPathComponent:NSStringFromClass([self class])] copy];
    }
    return _imageCacheDirectory;
}

- (NSString *)_cachePathForKey:(NSString *)key
{
    NSString *fileName = [NSString stringWithFormat:@"%lu", [key hash]];
    return [[self _imageCacheDirectory] stringByAppendingPathComponent:fileName];
}

- (NSUInteger)_totalDiskCacheSize
{
    NSString *cachePath = [self _imageCacheDirectory];
    if (!_cacheSize && cachePath) {
        __block NSUInteger totalSize = 0;
        NSFileManager *fm = [NSFileManager new];
        NSArray *contents = [fm contentsOfDirectoryAtPath:cachePath error:nil];
        [contents enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSDictionary *attributes = [fm attributesOfItemAtPath:[cachePath stringByAppendingPathComponent:obj] error:nil];
            totalSize += [[attributes objectForKey:NSFileSize] unsignedIntegerValue];
        }];
        self.cacheSize = totalSize;
    }
    return _cacheSize;
}

- (void)_pruneDiskCache
{
    NSUInteger targetBytes = self.maximumDiskCacheSize * 1024 * 1024;
    if ([self _totalDiskCacheSize] > targetBytes) {
        NSString *cachePath = [self _imageCacheDirectory];
        NSFileManager *fm = [NSFileManager new];;
        NSArray *contents = [fm contentsOfDirectoryAtPath:cachePath error:nil];
        NSMutableArray *paths = [NSMutableArray arrayWithCapacity:[contents count]];
        [contents enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [paths addObject:[cachePath stringByAppendingPathComponent:obj]];
        }];
        [paths sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            NSDictionary *attributes1 = [fm attributesOfItemAtPath:obj1 error:nil];
            NSDictionary *attributes2 = [fm attributesOfItemAtPath:obj2 error:nil];
            NSDate *modDate1 = [attributes1 valueForKey:NSFileModificationDate];
            NSDate *modDate2 = [attributes2 valueForKey:NSFileModificationDate];
            return [modDate1 compare:modDate2];
        }];
        NSUInteger currentCacheSize = self.cacheSize;
        while (currentCacheSize > targetBytes && [paths count]) {
            NSString *path = [paths lastObject];
            NSDictionary *attributes = [fm attributesOfItemAtPath:path error:nil];
            NSUInteger fileSize = [[attributes valueForKey:NSFileSize] unsignedIntegerValue];
            if ([fm removeItemAtPath:path error:nil]) {
                currentCacheSize -= fileSize;
                [paths removeLastObject];
            }
        }
        self.cacheSize = currentCacheSize;
    }
}
@end
