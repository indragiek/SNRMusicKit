//
//  SPUser+SMKUser.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-24.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SPUser+SMKUser.h"
#import "NSObject+SMKSpotifyAdditions.h"

@interface SPUser (SMKInternal)
@property (nonatomic, readwrite, assign) __unsafe_unretained SPSession *session;
@end

@implementation SPUser (SMKUser)

#pragma mark - SMKUser

- (NSString *)username
{
    return self.canonicalName;
}

#pragma mark - SMKContentObject

- (NSString *)name
{
    return self.displayName;
}

+ (NSSet *)supportedSortKeys
{
    return [NSSet setWithObjects:@"username", @"name", nil];
}

- (NSString *)uniqueIdentifier
{
    return [self.spotifyURL absoluteString];
}

- (id<SMKContentSource>)contentSource
{
    return (id<SMKContentSource>)self.session;
}

#pragma mark - SMKWebObject

- (NSURL *)webURL
{
    return self.spotifyURL;
}
@end
