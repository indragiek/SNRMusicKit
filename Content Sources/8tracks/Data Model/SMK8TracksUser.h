//
//  SMK8TracksUser.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-23.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMKUser.h"
#import "SMK8TracksObject.h"

enum {
    SMK8TracksUserAvatarSize56 = 0,
    SMK8TracksUserAvatarSize72 = 1,
    SMK8TracksUserAvatarSize100 = 2,
    SMK8TracksUserAvatarSize200 = 3,
    SMK8TracksUserAvatarSize250 = 4
};
typedef NSUInteger SMK8TracksUserAvatarSize;

@interface SMK8TracksUser : SMK8TracksObject <SMKUser>

#pragma mark - SMKUser

@property (nonatomic, strong, readonly) NSString *username;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSURL *webURL;
@property (nonatomic, strong, readonly) NSURL *smallArtworkURL;
@property (nonatomic, strong, readonly) NSURL *largeArtworkURL;
@property (nonatomic, strong, readonly) NSString *uniqueIdentifier;

#pragma mark - 8Tracks

/**
 Returns the URL for the user's avatar in the specified size
 @param size The size of the avatar to return
 @return The URL to the avatar image
 */
- (NSURL *)avatarURLForSize:(SMK8TracksUserAvatarSize)size;

/**
 The user's biography, in HTML format
 */
@property (nonatomic, strong, readonly) NSString *biography;

/**
 The number of users this user follows.
 */
@property (nonatomic, strong, readonly) NSNumber *followingCount;

/**
 The number of followers this user has.
 */
@property (nonatomic, strong, readonly) NSNumber *followerCount;

/**
 The user's 8tracks user ID.
 */
@property (nonatomic, strong, readonly) NSNumber *userID;

/**
 Boolean value indicating whether to hide NSFW content
 */
@property (nonatomic, strong, readonly) NSNumber *hideNSFW;

/**
 The user's location
 */
@property (nonatomic, strong, readonly) NSString *location;

/**
 Create an SMK8TracksUser object with the specified dictionary
 @param dictionary Dictionary to create object from
 @param contentSource The content source the user belongs to
 @return The SMK8TracksUser object
 */
+ (instancetype)userWithDictionary:(NSDictionary *)dictionary
                     contentSource:(id<SMKContentSource>)contentSource;
- (id)initWithDictionary:(NSDictionary *)dictionary
           contentSource:(id<SMKContentSource>)contentSource;

@end
