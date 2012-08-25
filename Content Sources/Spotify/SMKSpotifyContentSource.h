//
//  SMKSpotifyContentSource.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-24.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <CocoaLibSpotify/CocoaLibSpotify.h>
#import "SMKContentSource.h"

@interface SMKSpotifyContentSource : SPSession <SMKContentSource>
/** This queue is used to sort and filter content before it's returned */
@property (nonatomic, readonly) dispatch_queue_t spotifyLocalQueue;
@end
