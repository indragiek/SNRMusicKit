//
//  MPMediaItem+SMKAdditions.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-24.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "MPMediaItem+SMKAdditions.h"

@implementation MPMediaItem (SMKAdditions)
- (id<SMKArtist>)artist
{
    NSString *persistentID = [[self class] persistentIDPropertyForGroupingType:MPMediaGroupingAlbumArtist];
    MPMediaQuery *query = [MPMediaQuery artistsQuery];
    [query addFilterPredicate:[MPMediaPropertyPredicate predicateWithValue:persistentID forProperty:MPMediaItemPropertyPersistentID]];
    if ([[query items] count]) {
        return [[query items] objectAtIndex:0];
    }
}
@end
