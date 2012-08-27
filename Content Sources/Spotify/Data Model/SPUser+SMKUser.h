//
//  SPUser+SMKUser.h
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

#import "SMKUser.h"
#import "SMKWebObject.h"

@interface SPUser (SMKUser) <SMKUser, SMKWebObject>
@end
