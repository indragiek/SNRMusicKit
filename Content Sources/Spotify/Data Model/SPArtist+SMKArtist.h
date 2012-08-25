//
//  SPArtist+SMKArtist.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-24.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <CocoaLibSpotify/CocoaLibSpotify.h>
#import "SMKArtist.h"
#import "SMKWebObject.h"
#import "SMKArtworkObject.h"

@interface SPArtist (SMKArtist) <SMKArtist, SMKWebObject, SMKArtworkObject>
@end
