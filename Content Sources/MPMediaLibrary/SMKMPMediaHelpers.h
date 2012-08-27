//
//  SMKMPMediaHelpers.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-27.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface SMKMPMediaHelpers : NSObject
/**
 Creates a property predicate using either the album artist name (or the artist name)
 If neither value is available, returns nil.
 @param item The item to create a predicate from
 @return Predicate for matching the artist name
 */
+ (MPMediaPropertyPredicate *)predicateForArtistNameOfItem:(MPMediaItem *)item;
@end
