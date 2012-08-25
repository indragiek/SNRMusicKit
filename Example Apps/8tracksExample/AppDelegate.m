//
//  AppDelegate.m
//  8tracksExample
//
//  Created by Indragie Karunaratne on 2012-08-23.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "AppDelegate.h"
#import <SNRMusicKitMac/SMK8TracksContentSource.h>

@implementation AppDelegate {
    SMK8TracksContentSource *_source;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    _source = [SMK8TracksContentSource new];
    [_source setAPIKey:@"API_KEY"];
    [_source authenticateWithUsername:@"USERNAME" password:@"PASSWORD" success:^(SMK8TracksUser *user) {
        [_source getPath:@"mixes/1002" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@", responseObject);
        } failure:nil];
    } failure:nil];
}

@end
