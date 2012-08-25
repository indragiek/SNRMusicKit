//
//  SPAlbum+SMKAlbum.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-24.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <CocoaLibSpotify/CocoaLibSpotify.h>
#import "SMKAlbum.h"
#import "SMKWebObject.h"
#import "SMKArtworkObject.h"

@interface SPAlbum (SMKAlbum) <SMKAlbum, SMKWebObject, SMKArtworkObject>
- (SPAlbumBrowse *)SMK_associatedAlbumBrowse;
@end
