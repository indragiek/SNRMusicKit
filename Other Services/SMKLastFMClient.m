//
//  SMKLastFMClient.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-26.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SMKLastFMClient.h"
#import "AFJSONRequestOperation.h"
#import "NSString+SMKAdditions.h"
#import "SSKeychain.h"

static NSString* const SMKLastFMHTTClientBaseURL = @"http://ws.audioscrobbler.com/2.0/";
static NSString* const SMKLastFMServiceName = @"Last.fm";

@implementation SMKLastFMClient {
    NSString *_sessionKey;
}

#pragma mark - Initialization

- (id)init
{
    if ((self = [super initWithBaseURL:[NSURL URLWithString:SMKLastFMHTTClientBaseURL]])) {
        [self setParameterEncoding:AFJSONParameterEncoding];
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
    }
    return self;
}

+ (instancetype)sharedInstance
{
    static SMKLastFMClient *client;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        client = [[SMKLastFMClient alloc] init];
    });
    return client;
}

#pragma mark - AFHTTPClient

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:parameters];
    if (self.APIKey) params[@"api_key"] = self.APIKey;
    if (_sessionKey) params[@"sk"] = _sessionKey;
    params[@"api_sig"] = [self _methodSignatureWithParameters:parameters];
    params[@"format"] = @"json";
    return [super requestWithMethod:method path:path parameters:params];
}

#pragma mark - Login

- (BOOL)loginWithUsername:(NSString *)username
{
    NSString *key = [SSKeychain passwordForService:SMKLastFMServiceName account:username];
    if ([key length]) {
        _username = username;
        _sessionKey = key;
        return YES;
    }
    return NO;
}

- (void)logout
{
    _username = nil;
    _sessionKey = nil;
}

#pragma mark - Web Authentication

- (NSURL*)webAuthenticationURLWithCallbackURL:(NSURL*)callback
{
    NSMutableString *URLString = [NSMutableString stringWithFormat:@"%@?api_key=%@", SMKLastFMHTTClientBaseURL, self.APIKey];
    if (callback) { [URLString appendFormat:@"&cb=%@", callback]; }
    return [NSURL URLWithString:URLString];
}

#pragma mark - Desktop Authentication

- (void)retrieveAuthenticationToken:(void (^)(NSString *token, NSError *error))handler;
{
    [self getPath:nil parameters:@{@"method" : @"auth.getToken"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (handler) handler(responseObject[@"token"], nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (handler) handler(nil, error);
    }];
}

- (NSURL*)authenticationURLWithToken:(NSString*)token
{
	NSString *URLString = [NSString stringWithFormat:@"%@?api_key=%@&token=%@", SMKLastFMHTTClientBaseURL, self.APIKey, token];
	return [NSURL URLWithString:URLString];
}

#pragma mark - Mobile Authentication

- (void)retrieveAndStoreSessionKeyWithUsername:(NSString*)username password:(NSString*)password completionHandler:(void (^)(NSError *error))handler;
{
    NSString *authToken = [[NSString stringWithFormat:@"%@%@", [username lowercaseString], [password SMK_MD5Hash]] SMK_MD5Hash];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    if (username) parameters[@"username"] = username;
    if (authToken) parameters[@"authToken"] = authToken;
    parameters[@"method"] = @"auth.getMobileSession";
    [self getPath:nil parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error = nil;
        NSDictionary *session = responseObject[@"session"];
        [self _storeCredentialsWithUsername:session[@"name"] sessionKey:session[@"key"] error:&error];
        if (handler) handler(error);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (handler) handler(error);
    }];
}

#pragma mark - Keychain Access

- (void)retrieveAndStoreSessionKeyWithToken:(NSString*)token completionHandler:(void (^)(NSString *user, NSError *error))handler
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"method"] = @"auth.getSession";
    if (token) parameters[@"token"] = token;
    [self getPath:nil parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error = nil;
        NSDictionary *session = responseObject[@"session"];
        [self _storeCredentialsWithUsername:session[@"name"] sessionKey:session[@"key"] error:&error];
        if (handler) handler(session[@"name"], error);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (handler) handler(nil, error);
    }];
}

+ (BOOL)userHasStoredCredentials:(NSString*)user
{
    NSString *key = [SSKeychain passwordForService:SMKLastFMServiceName account:user];
	return [key length] != 0;
}

+ (void)removeCredentialsForUser:(NSString*)user
{
    [SSKeychain deletePasswordForService:SMKLastFMServiceName account:user];
}

- (BOOL)isAuthenticated
{
    return (_sessionKey != nil);
}

#pragma mark - Scrobbling

- (void)scrobbleTrackWithName:(NSString*)name
                        album:(NSString*)album
                       artist:(NSString*)artist
                  albumArtist:(NSString*)albumArtist
                  trackNumber:(NSInteger)trackNumber
                     duration:(NSInteger)duration
                    timestamp:(NSInteger)timestamp
            completionHandler:(void (^)(NSDictionary *scrobbles, NSError *error))handler
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"method"] = @"track.scrobble";
    if (name) parameters[@"track"] = name;
    if (album) parameters[@"album"] = album;
    if (artist) parameters[@"artist"] = artist;
    if (albumArtist) parameters[@"albumArtist"] = albumArtist;
    parameters[@"trackNumber"] = @(trackNumber);
    parameters[@"duration"] = @(duration);
    parameters[@"timestamp"] = @(timestamp);
    [self postPath:nil parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (handler) handler(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (handler) handler(nil, error);
    }];
}

- (void)updateNowPlayingTrackWithName:(NSString*)name
                                album:(NSString*)album
                               artist:(NSString*)artist
                          albumArtist:(NSString*)albumArtist
                          trackNumber:(NSInteger)trackNumber
                             duration:(NSInteger)duration
                    completionHandler:(void (^)(NSDictionary *response, NSError *error))handler
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"method"] = @"track.updateNowPlaying";
    if (name) parameters[@"track"] = name;
    if (album) parameters[@"album"] = album;
    if (artist) parameters[@"artist"] = artist;
    if (albumArtist) parameters[@"albumArtist"] = albumArtist;
    parameters[@"trackNumber"] = @(trackNumber);
    parameters[@"duration"] = @(duration);
    [self postPath:nil parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (handler) handler(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (handler) handler(nil, error);
    }];
}

- (void)loveTrackWithName:(NSString*)name
                   artist:(NSString*)artist
        completionHandler:(void (^)(NSDictionary *response, NSError *error))handler
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"method"] = @"track.love";
    if (name) parameters[@"track"] = name;
    parameters[@"artist"] = artist;
    [self postPath:nil parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (handler) handler(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (handler) handler(nil, error);
    }];
}

#pragma mark - Private

- (NSString*)_methodSignatureWithParameters:(NSDictionary*)parameters
{
	NSArray *keys = [[parameters allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
	NSMutableString *parameterString = [NSMutableString string];
	for (NSString *key in keys) { // Append each of the key-value pairs in alphabetical order
		[parameterString appendString:key];
		[parameterString appendString:[[parameters valueForKey:key] description]];
	}
	[parameterString appendString:self.APISecret]; // Append secret
	return [parameterString SMK_MD5Hash]; // Create an MD5 hash
}

#pragma mark - Keychain

- (void)_storeCredentialsWithUsername:(NSString*)username sessionKey:(NSString*)key error:(NSError**)error
{
    if ([SSKeychain setPassword:key forService:SMKLastFMServiceName account:username error:error])
        _username = username;
}
@end
