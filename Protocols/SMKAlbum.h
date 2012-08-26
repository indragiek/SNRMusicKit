//
//  SMKAlbum.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-21.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMKContentSource.h"
#import "SMKArtist.h"

#import "SMKContentObject.h"

@protocol SMKAlbum <NSObject, SMKContentObject>
@required
/**
 @return The artist of the album.
 */
- (id<SMKArtist>)artist;

/**
 This method will fetch the tracks asynchronously and call the completion handler when finished.
 @param sortDescriptors Array of NSSortDescriptor objects used to sort the content
 @param predicate A predicate to filter the results with
 @param batchSize If this is not set to 0, the results will be fetched in batches of this many objects *providing that the source supports batching*
 @param fetchLimit A limit on the number of objects to return
 @discussion This method is asynchronous and will return immediately.
 */
- (void)fetchTracksWithSortDescriptors:(NSArray *)sortDescriptors
                             predicate:(NSPredicate *)predicate
                             batchSize:(NSUInteger)batchSize
                            fetchLimit:(NSUInteger)fetchLimit
                     completionHandler:(void(^)(NSArray *tracks, NSError *error))handler;

@optional
/**
 @return The release year of the album
 */
- (NSUInteger)releaseYear;

/**
 @return The duration of the album in seconds.
 */
- (NSTimeInterval)duration;

/**
 @return Whether the album is a compilation.
 */
- (BOOL)isCompilation;
@end
