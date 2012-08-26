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
 This method will fetch the playlists asynchronously and call the completion handler when finished.
 @param sortDescriptors Array of NSSortDescriptor objects used to sort the content
 @param predicate A predicate to filter the results with
 @param batchSize If this is not set to 0, the results will be fetched in batches of this many objects *providing that the source supports batching*
 @param fetchLimit A limit on the number of objects to return
 @discussion This method is asynchronous and will return immediately.
 */
- (void)fetchPlaylistsWithSortDescriptors:(NSArray *)sortDescriptors
                                batchSize:(NSUInteger)batchSize
                               fetchLimit:(NSUInteger)fetchLimit
                                predicate:(NSPredicate *)predicate
                        completionHandler:(void(^)(NSArray *playlists, NSError *error))handler;

/**
 @return Whether the source supports fetching data in batches.
 */
+ (BOOL)supportsBatching;

/**
 @return The class of the default player for this content source
 */
+ (Class)defaultPlayerClass;
@end
