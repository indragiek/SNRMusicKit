//
//  SMK8TracksContentSource.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-23.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "AFHTTPClient.h"
#import "SMKContentSource.h"
#import "SMK8TracksUser.h"

@interface SMK8TracksContentSource : AFHTTPClient <SMKContentSource>

#pragma mark - Authentication

/**
 This method needs to be called before making any calls to the API.
 @param key The API key to use for making calls to the 8tracks API
 */
- (void)setAPIKey:(NSString *)key;

/**
 Authenticate with the specified credentials.
 @param username The username
 @param password The password
 @param sucess Completion handler called upon success
 @param failure Completion handler called upon failure
 */
- (void)authenticateWithUsername:(NSString *)username
                        password:(NSString *)password
                         success:(void(^)(SMK8TracksUser *user))success
                         failure:(void(^)(NSError *error))failure;

/**
 Create a user account with the specified information.
 @param username The username to create the account with
 @param password The account password
 @param email User's email address
 @discussion After this method is called, if account creation is successful
 then the user will be automatically authenticated
 */
- (void)createAccountWithUsername:(NSString *)username
                         password:(NSString *)password
                            email:(NSString *)email
                          success:(void(^)(SMK8TracksUser *user))success
                          failure:(void(^)(NSError *error))failure;


#pragma mark - Mixes

- (void)getLatestTenMixesWithSuccess:(void(^)(SMK8TracksUser *user))success
                         failure:(void(^)(NSError *error))failure;

@end
