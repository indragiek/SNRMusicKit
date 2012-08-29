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
 @param predicate A predicate to filter the results with. Use SMKContentSource +predicateClass to find out which
 class the content source expects its predicate to use.
 @discussion This method is asynchronous and will return immediately.
 */
- (void)fetchPlaylistsWithSortDescriptors:(NSArray *)sortDescriptors
                                predicate:(id)predicate
                        completionHandler:(void(^)(NSArray *playlists, NSError *error))handler;

/**
 @return The class of the predicate used to sort objects from this content source
 */
+ (Class)predicateClass;
@end
