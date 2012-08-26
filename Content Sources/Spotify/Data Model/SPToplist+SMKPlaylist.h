//
//  SPToplist+SMKPlaylist.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-26.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <CocoaLibSpotify/CocoaLibSpotify.h>
#import "SMKPlaylist.h"
#import "SMKHierarchicalLoading.h"

@interface SPToplist (SMKPlaylist) <SMKPlaylist, SMKHierarchicalLoading>
@property (nonatomic, copy) NSString *name;
@end
