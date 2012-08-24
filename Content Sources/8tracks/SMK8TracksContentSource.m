//
//  SMK8TracksContentSource.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-23.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SMK8TracksContentSource.h"
#import "AFJSONRequestOperation.h"

static NSString* const SMK8TracksHTTClientAPIKeyHeader = @"X-Api-Key";
static NSString* const SMK8TracksHTTClientUserTokenHeader = @"X-User-Token";
static NSString* const SMK8TracksHTTClientBaseURL = @"https://8tracks.com/";

@implementation SMK8TracksContentSource

- (id)init
{
    if ((self = [super initWithBaseURL:[NSURL URLWithString:SMK8TracksHTTClientBaseURL]])) {
        [self setParameterEncoding:AFJSONParameterEncoding];
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
    }
    return self;
}

// Use the JSON format for everything
- (NSMutableURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [params setValue:@"json" forKey:@"format"];
    return [super requestWithMethod:method path:path parameters:params];
}

#pragma mark - Authentication

- (void)setAPIKey:(NSString *)key
{
    [self setDefaultHeader:SMK8TracksHTTClientAPIKeyHeader value:key];
}

- (void)authenticateWithUsername:(NSString *)username
                        password:(NSString *)password
                         success:(void(^)(SMK8TracksUser *user))success
                         failure:(void(^)(NSError *error))failure
{
    [self postPath:@"sessions" parameters:@{@"login" : username, @"password" : password} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        if ([responseObject[@"logged_in"] boolValue]) {
            [self setDefaultHeader:SMK8TracksHTTClientUserTokenHeader value:responseObject[@"user_token"]];
            SMK8TracksUser *user = [SMK8TracksUser userWithDictionary:responseObject[@"current_user"]];
            if (success) success(user);
        } else {
            if (failure) failure(nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) failure(error);
    }];
}

- (void)createAccountWithUsername:(NSString *)username
                         password:(NSString *)password
                            email:(NSString *)email
                          success:(void(^)(SMK8TracksUser *user))success
                          failure:(void(^)(NSError *error))failure
{
    [self postPath:@"users" parameters:@{@"user[login]" : username, @"user[password]" : password, @"user[email]" : email, @"user[agree_to_terms]" : @1} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"logged_in"] boolValue]) {
            [self setDefaultHeader:SMK8TracksHTTClientUserTokenHeader value:responseObject[@"user_token"]];
            SMK8TracksUser *user = [SMK8TracksUser userWithDictionary:responseObject[@"current_user"]];
            if (success) success(user);
        } else {
            if (failure) failure(nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) failure(error);
    }];
}
@end
