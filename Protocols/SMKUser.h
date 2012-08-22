//
//  SMKUser.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-21.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMKContentSource.h"
#import "SMKContentObject.h"
#import "SMKArtworkSource.h"
#import "SMKWebObject.h"

@protocol SMKUser <NSObject, SMKContentObject, SMKArtworkSource, SMKWebObject>
@required

/**
 @return The username of the user
 */
- (NSString *)username;

@optional

/**
 @return The display name of the user (real name)
 */
- (NSString *)displayName;
@end
