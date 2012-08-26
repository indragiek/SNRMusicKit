//
//  SMKArtworkCache.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-25.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SMKArtworkCache.h"

static NSString *_imageCacheDirectory;

@interface SMKArtworkCache ()
@property (nonatomic, assign) NSUInteger cacheSize;
@end

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
        self.JPEGCompressionQuality = 1.0; // Best quality
        self.maximumDiskCacheSize = 50; // MB
        _diskOperationQueue = dispatch_queue_create("com.indragie.SNRMusicKit.artworkDiskOperationQueue", DISPATCH_QUEUE_SERIAL);
        [[NSFileManager defaultManager] createDirectoryAtPath:[self _imageCacheDirectory] withIntermediateDirectories:YES attributes:nil error:nil];
        [self _pruneDiskCache];
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
    __weak SMKArtworkCache *weakSelf = self;
    dispatch_async(_diskOperationQueue, ^{
        SMKArtworkCache *strongSelf = weakSelf;
        NSString *cachePath = [strongSelf _imageCacheDirectory];
        NSFileManager *fm = [NSFileManager new];
        [fm removeItemAtPath:cachePath error:nil];
        [fm createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:nil error:nil];
    });
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

- (NSUInteger)_totalDiskCacheSize
{
    NSString *cachePath = [self _imageCacheDirectory];
    if (!_cacheSize && cachePath) {
        __block NSUInteger totalSize = 0;
        NSFileManager *fm = [NSFileManager defaultManager];
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
    __weak SMKArtworkCache *weakSelf = self;
    dispatch_async(_diskOperationQueue, ^{
        SMKArtworkCache *strongSelf = weakSelf;
        NSUInteger targetBytes = strongSelf.maximumDiskCacheSize * 1024 * 1024;
        if ([strongSelf _totalDiskCacheSize] > targetBytes) {
            NSString *cachePath = [strongSelf _imageCacheDirectory];
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
            NSUInteger currentCacheSize = strongSelf.cacheSize;
            while (currentCacheSize > targetBytes && [paths count]) {
                NSString *path = [paths lastObject];
                NSDictionary *attributes = [fm attributesOfItemAtPath:path error:nil];
                NSUInteger fileSize = [[attributes valueForKey:NSFileSize] unsignedIntegerValue];
                if ([fm removeItemAtPath:path error:nil]) {
                    currentCacheSize -= fileSize;
                    [paths removeLastObject];
                }
            }
            strongSelf.cacheSize = currentCacheSize;
        }
    });
}
@end
