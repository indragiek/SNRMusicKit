//
//  SPPlaylist+SMKPlaylist.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-24.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#if TARGET_OS_IPHONE
#import "CocoaLibSpotify.h"
#else
#import <CocoaLibSpotify/CocoaLibSpotify.h>
#endif

#import "SMKPlaylist.h"
#import "SMKWebObject.h"
#import "SMKArtworkObject.h"
#import "SMKHierarchicalLoading.h"

@interface SPPlaylist (SMKPlaylist) <SMKPlaylist, SMKArtworkObject, SMKWebObject, SMKHierarchicalLoading>

#pragma mark - SMKPlaylist

- (id<SMKUser>)user;
- (NSString *)extendedDescription;
- (void)moveTracks:(NSArray*)tracks toIndex:(NSUInteger)index completionHandler:(void(^)(NSError *error))handler;
@end

@interface SPPlaylistItem (SMKPlaylist) <SMKHierarchicalLoading>
@end

@interface SPPlaylistContainer (SMKPlaylist) <SMKHierarchicalLoading>
@end