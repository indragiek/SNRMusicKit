//
//  SPAlbum+SMKAlbum.h
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

#import "SMKAlbum.h"
#import "SMKWebObject.h"
#import "SMKArtworkObject.h"
#import "SMKHierarchicalLoading.h"

@interface SPAlbum (SMKAlbum) <SMKAlbum, SMKWebObject, SMKArtworkObject, SMKHierarchicalLoading>
- (SPAlbumBrowse *)SMK_associatedAlbumBrowse;
@end

@interface SPAlbumBrowse (SMKAlbum) <SMKHierarchicalLoading>
@end