//
//  SPPlaylist+SMKPlaylist.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-24.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <CocoaLibSpotify/CocoaLibSpotify.h>
#import "SMKPlaylist.h"
#import "SMKWebObject.h"
#import "SMKArtworkObject.h"

@interface SPPlaylist (SMKPlaylist) <SMKPlaylist, SMKArtworkObject, SMKWebObject>

#pragma mark - SMKPlaylist

- (void)moveTracks:(NSArray*)tracks
           toIndex:(NSUInteger)index
 completionHandler:(void(^)(NSError *error))handler;
@end
