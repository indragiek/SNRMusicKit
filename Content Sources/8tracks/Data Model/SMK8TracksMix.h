//
//  SMK8TracksMix.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-23.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMK8TracksObject.h"
#import "SMKPlaylist.h"
#import "SMKUser.h"

@interface SMK8TracksMix : SMK8TracksObject <SMKPlaylist>
#pragma mark - SMKPlaylist
@property (nonatomic, strong, readonly) id<SMKUser> user;
@property (nonatomic, strong, readonly) NSString *extendedDescription;
@end
