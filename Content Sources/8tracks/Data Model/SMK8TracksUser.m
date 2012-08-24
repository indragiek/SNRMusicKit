//
//  SMK8TracksUser.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-23.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SMK8TracksUser.h"

static NSString* const SMK8TracksUserWebBaseURL = @"http://8tracks.com";

@implementation SMK8TracksUser {
    NSDictionary *_avatarURLs;
}

#pragma mark - Initialization

+ (instancetype)userWithDictionary:(NSDictionary *)dictionary
{
    return [[SMK8TracksUser alloc] initWithDictionary:dictionary];
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if ((self = [super init])) {
        _avatarURLs = dictionary[@"avatar_urls"];
        _biography = dictionary[@"bio_html"];
        _followingCount = dictionary[@"followed_by_current_user"];
        _followerCount = dictionary[@"follows_count"];
        _userID = dictionary[@"id"];
        _hideNSFW = dictionary[@"hide_nsfw"];
        _location = dictionary[@"location"];
        _username = dictionary[@"username"];
        _name = dictionary[@"username"];
        NSString *URLString = [SMK8TracksUserWebBaseURL stringByAppendingString:dictionary[@"path"]];
        _webURL = [NSURL URLWithString:URLString];
        _smallArtworkURL = [self avatarURLForSize:SMK8TracksUserAvatarSize72];
        _largeArtworkURL = [self avatarURLForSize:SMK8TracksUserAvatarSize250];
        _uniqueIdentifier = [_userID stringValue];
    }
    return self;
}

#pragma mark - 8Tracks

- (NSURL *)avatarURLForSize:(SMK8TracksUserAvatarSize)size
{
    NSString *URLString = nil;
    switch (size) {
        case SMK8TracksUserAvatarSize56:
            URLString = _avatarURLs[@"sq56"];
            break;
        case SMK8TracksUserAvatarSize72:
            URLString = _avatarURLs[@"sq72"];
            break;
        case SMK8TracksUserAvatarSize100:
            URLString = _avatarURLs[@"sq100"];
            break;
        case SMK8TracksUserAvatarSize200:
            URLString = _avatarURLs[@"max200"];
            break;
        case SMK8TracksUserAvatarSize250:
            URLString = _avatarURLs[@"max250w"];
        default:
            URLString = _avatarURLs[@"sq100"];
            break;
    }
    return [NSURL URLWithString:URLString];
}
@end
