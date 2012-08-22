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
#import "SMKArtworkSource.h"
#import "SMKWebObject.h"

@protocol SMKAlbum <NSObject, SMKContentObject, SMKArtworkSource, SMKWebObject>
@required
/**
 @return The artist of the album.
 */
- (id<SMKArtist>)artist;

/**
 @param error An NSError object with error information if it was unsuccessful.
 @param sortDescriptors Array of NSSortDescriptor objects used to sort the content
 @param predicate A predicate to filter the results with
 @param batchSize If this is not set to 0, the results will be fetched in batches of this many objects *providing that the source supports batching*
 @param fetchLimit A limit on the number of objects to return
 @return an array of objects conforming to the SMKTrack protocol.
 @discussion This method is synchronous, and will block until the tracks have been fetched.
 */
- (NSArray *)tracksWithSortDescriptors:(NSArray *)sortDescriptors predicate:(NSPredicate *)predicate batchSize:(NSUInteger)batchSize fetchLimit:(NSUInteger)fetchLimit error:(NSError **)error;

/**
 This method will fetch the tracks asynchronously and call the completion handler when finished.
 @param sortDescriptors Array of NSSortDescriptor objects used to sort the content
 @param predicate A predicate to filter the results with
 @param batchSize If this is not set to 0, the results will be fetched in batches of this many objects *providing that the source supports batching*
 @param fetchLimit A limit on the number of objects to return
 @discussion This method is asynchronous and will return immediately.
 */
- (void)fetchTracksWithSortDescriptors:(NSArray *)sortDescriptors predicate:(NSPredicate *)predicate batchSize:(NSUInteger)batchSize fetchLimit:(NSUInteger)fetchLimit completionHandler:(void(^)(NSArray *tracks, NSError *error))handler;

@optional
/**
 @return The release year of the album
 */
- (NSNumber *)releaseYear;

/**
 @return The release date of the album.
 */
- (NSDate *)releaseDate;

/**
 @return The duration of the album in seconds.
 */
- (NSNumber *)duration;

/**
 @return Whether the album is a compilation.
 */
- (NSNumber *)isCompilation;

/**
 @return Whether the album contains explicit content.
 */
- (NSNumber *)isExplicit;

/**
 @return Whether the album is free of explicit content.
 */
- (NSNumber *)isClean;

/**
 @return Whether the album can be streamed from the content source.
 */
- (BOOL)canStream;

/**
 Plays the album
 @return Whether the album was successfully played.
 @param error An NSError object with error information if it was unsuccessful.
 */
- (BOOL)playWithError:(NSError **)error;
@end
