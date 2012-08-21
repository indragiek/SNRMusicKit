//
//  SMKUser.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-21.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMKContentSource.h"

@protocol SMKUser <NSObject>
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

/**
 @return The URL to the profile page for this user
 */
- (NSURL *)webURL;

/**
 @return URL to retrieve the user's thumbnail avatar image from
 @discussion This could be a local or remote URL.
 */
- (NSURL *)smallAvatarURL;

/**
 @return URL to retrieve the user's full size avatar image from
 @discussion This could be a local or remote URL.
 */
- (NSURL *)largeAvatarURL;
@end
