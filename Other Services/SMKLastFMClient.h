//
//  SMKLastFMClient.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-26.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "AFHTTPClient.h"

@interface SMKLastFMClient : AFHTTPClient
/** 
 API key and secret. Both of these can be obtained from Last.fm's developer page
 <http://www.last.fm/api/account>
 */
@property (nonatomic, copy) NSString *APIKey;
@property (nonatomic, copy) NSString *APISecret;

/** 
 Username of the currently signed in user
 */
@property (nonatomic, copy, readonly) NSString *username;

/**
 Returns the shared instance ot SMKLastFMKClient
 */
+ (instancetype)sharedInstance;

/**
 Attempts to log in with the specified username and fetch a previously saved session key
 from the keychain. 
 @param username The login username
 @return Whether the specified username has a saved session key. If not, you need to
 use the authentication methods to retrieve and store the session key for future use, then
 call this method again to log in.
 */
- (BOOL)loginWithUsername:(NSString *)username;

/**
 Logs out the current user from the Last.fm client.
 */
- (void)logout;

#pragma mark -
#pragma mark Authentication

/**
 Used by desktop & web authentication. Retrieves a session key using a given token and stores it in the OS X Keychain
 @param token an authentication token
 @param handler a completion handler block
 */
- (void)retrieveAndStoreSessionKeyWithToken:(NSString*)token
                          completionHandler:(void (^)(NSString *user, NSError *error))handler;

#pragma mark -
#pragma mark Web Authentication

/**
 Returns a web authentication URL that can have a callback URL.
 @param callback Callback URL to open when the user has authenticated with Last.fm
 See here for more info on custom auth handlers <http://www.last.fm/api/webauth#create_an_authentication_handler>
 */
- (NSURL*)webAuthenticationURLWithCallbackURL:(NSURL*)callback;

#pragma mark -
#pragma mark Desktop Authentication

/**
 Retrieves a new authentication token from the Last.fm API
 @param handler a completion handler block
 */
- (void)retrieveAuthenticationToken:(void (^)(NSString *token, NSError *error))handler;

/**
 Returns an authentication URL that can be opened in a browser to authenticate your application with a user's Last.fm account
 @param token an authentication token obtained from the -retrieveAuthenticationToken: method
 @returns an authenticantion URL
 */
- (NSURL*)authenticationURLWithToken:(NSString*)token;

#pragma mark -
#pragma mark Mobile Authentication

/**
 Returns an authorization token with the specified credentials
 @param username the user's username
 @param password the user's password
 @param handler a completion handler block
 */
- (void)retrieveAndStoreSessionKeyWithUsername:(NSString*)username
                                      password:(NSString*)password
                             completionHandler:(void (^)(NSError *error))handler;

#pragma mark -
#pragma mark Keychain Access

/**
 Checks if the specified user has credentials stored in the keychain
 @param user the username
 @returns whether the user has stored credentials or not
 */
+ (BOOL)userHasStoredCredentials:(NSString*)user;

/**
 Deletes the credentials for the specified user from the keychain
 @param user the username
 */
+ (void)removeCredentialsForUser:(NSString*)user;

/**
 Checks whether the current instance of SMKLastFMClient is authenticated
 */
- (BOOL)isAuthenticated;

#pragma mark -
#pragma mark Scrobbling/Now Playing

/**
 Scrobbles a track with the given parameters
 @param name the track name
 @param album the name of the track's album
 @param artist the name of the track's artist
 @param albumArtist the name of the track's album artist
 @param track the track number
 @param duration the duration of the track (must be an integer)
 @param timestamp the timestamp at which the track was played --> use [NSNumber numberWithInteger:[[NSDate date] timeIntervalSince1970]] because the timestamp *must* be an integer
 @param handler a completion handler block
 */
- (void)scrobbleTrackWithName:(NSString*)name
                        album:(NSString*)album
                       artist:(NSString*)artist
                  albumArtist:(NSString*)albumArtist
                  trackNumber:(NSInteger)trackNumber
                     duration:(NSInteger)duration
                    timestamp:(NSInteger)timestamp
            completionHandler:(void (^)(NSDictionary *scrobbles, NSError *error))handler;

/**
 Sets the current user's now playing track with the given parameters
 @param name the track name
 @param album the name of the track's album
 @param artist the name of the track's artist
 @param albumArtist the name of the track's album artist
 @param track the track number
 @param duration the duration of the track
 @param timestamp the timestamp at which the track was played --> use [NSNumber numberWithInteger:[[NSDate date] timeIntervalSince1970]] because the timestamp *must* be an integer
 @param handler a completion handler block
 */
- (void)updateNowPlayingTrackWithName:(NSString*)name
                                album:(NSString*)album
                               artist:(NSString*)artist
                          albumArtist:(NSString*)albumArtist
                          trackNumber:(NSInteger)trackNumber
                             duration:(NSInteger)duration
                    completionHandler:(void (^)(NSDictionary *response, NSError *error))handler;

/**
 Loves the track with the specified information.
 @param name The track name
 @param artist The artist name
 */
- (void)loveTrackWithName:(NSString*)name
                   artist:(NSString*)artist
        completionHandler:(void (^)(NSDictionary *response, NSError *error))handler;
@end
