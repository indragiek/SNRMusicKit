//
//  SPArtist+SMKArtist.h
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

#import "SMKArtist.h"
#import "SMKWebObject.h"
#import "SMKArtworkObject.h"
#import "SMKHierarchicalLoading.h"

@interface SPArtist (SMKArtist) <SMKArtist, SMKWebObject, SMKArtworkObject, SMKHierarchicalLoading>
- (SPArtistBrowse *)SMK_associatedArtistBrowse;
@end

@interface SPArtistBrowse (SMKArtist) <SMKHierarchicalLoading>
@end