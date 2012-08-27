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
 @param predicate A predicate to filter the results with. Use SMKContentSource +predicateClass to find out which 
 class the content source expects its predicate to use.
 @discussion This method is asynchronous and will return immediately.
 */
- (void)fetchTracksWithSortDescriptors:(NSArray *)sortDescriptors
                             predicate:(id)predicate
                     completionHandler:(void(^)(NSArray *tracks, NSError *error))handler;

@optional
/**
 @return The release year of the album
 */
- (NSUInteger)releaseYear;

/**
 @return The rating of the album
 */
- (NSUInteger)rating;

/**
 @return The duration of the album in seconds.
 */
- (NSTimeInterval)duration;

/**
 @return Whether the album is a compilation.
 */
- (BOOL)isCompilation;
@end
