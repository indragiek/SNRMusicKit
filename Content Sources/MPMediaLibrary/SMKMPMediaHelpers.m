//
//  SMKMPMediaHelpers.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-27.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SMKMPMediaHelpers.h"

@implementation SMKMPMediaHelpers
+ (MPMediaPropertyPredicate *)predicateForArtistNameOfItem:(MPMediaItem *)item
{
    NSString *albumArtistName = [item valueForKey:MPMediaItemPropertyAlbumArtist];
    NSString *artistName = [item valueForKey:MPMediaItemPropertyArtist];
    if ([albumArtistName length]) {
        return [MPMediaPropertyPredicate predicateWithValue:albumArtistName forProperty:MPMediaItemPropertyAlbumArtist];
    } else {
        return [MPMediaPropertyPredicate predicateWithValue:artistName forProperty:MPMediaItemPropertyArtist];
    }
    return nil;
}
@end
