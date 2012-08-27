//
//  SPToplist+SMKPlaylist.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-26.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#if TARGET_OS_IPHONE
#import "CocoaLibSpotify.h"
#else
#import <CocoaLibSpotify/CocoaLibSpotify.h>
#endif

#import "SMKPlaylist.h"
#import "SMKHierarchicalLoading.h"

@interface SPToplist (SMKPlaylist) <SMKPlaylist, SMKHierarchicalLoading>
@property (nonatomic, copy) NSString *name;
@end
