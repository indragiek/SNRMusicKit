//
//  SMKLastFMClient+SMKTrack.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-26.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SMKLastFMClient+SMKTrack.h"

@implementation SMKLastFMClient (SMKTrack)
- (void)scrobbleTrack:(id<SMKTrack>)track completionHandler:(void (^)(NSDictionary *scrobbles, NSError *error))handler
{
    NSUInteger trackNumber = [track respondsToSelector:@selector(trackNumber)] ? [track trackNumber] : 0;
    NSUInteger timeStamp = [[NSDate date] timeIntervalSince1970];
    [self scrobbleTrackWithName:[track name]
                          album:[[track album] name]
                         artist:[track artistName]
                    albumArtist:[track albumArtistName]
                    trackNumber:trackNumber
                       duration:[track duration]
                      timestamp:timeStamp
              completionHandler:handler];
}

- (void)updateNowPlayingWithTrack:(id<SMKTrack>)track completionHandler:(void (^)(NSDictionary *response, NSError *error))handler
{
    NSUInteger trackNumber = [track respondsToSelector:@selector(trackNumber)] ? [track trackNumber] : 0;
    [self updateNowPlayingTrackWithName:[track name]
                                  album:[[track album] name]
                                 artist:[track artistName]
                            albumArtist:[track albumArtistName]
                            trackNumber:trackNumber
                               duration:[track duration]
                      completionHandler:handler];
}

- (void)loveTrack:(id<SMKTrack>)track completionHandler:(void (^)(NSDictionary *response, NSError *error))handler
{
    [self loveTrackWithName:[track name] artist:[track artistName] completionHandler:handler];
}
@end
