//
//  SPTrack+SMKTrack.h
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

#import "SMKTrack.h"
#import "SMKWebObject.h"
#import "SMKHierarchicalLoading.h"

@interface SPTrack (SMKTrack) <SMKTrack, SMKWebObject, SMKHierarchicalLoading>
@end
