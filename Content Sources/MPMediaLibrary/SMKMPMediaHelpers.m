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
    NSNumber *albumArtist = [item valueForProperty:MPMediaItemPropertyAlbumArtistPersistentID];
    NSString *artist = [item valueForProperty:MPMediaItemPropertyArtistPersistentID];
    if (albumArtist) {
        return [MPMediaPropertyPredicate predicateWithValue:albumArtist forProperty:MPMediaItemPropertyAlbumArtistPersistentID];
    } else {
        return [MPMediaPropertyPredicate predicateWithValue:artist forProperty:MPMediaItemPropertyArtistPersistentID];
    }
}
@end
