//
//  SMKSpotifyContentSource.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-24.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#if TARGET_OS_IPHONE
#import "CocoaLibSpotify.h"
#else
#import <CocoaLibSpotify/CocoaLibSpotify.h>
#endif

#import "SMKContentSource.h"
#import "SPUser+SMKUser.h"
#import "SPPlaylist+SMKPlaylist.h"
#import "SPTrack+SMKTrack.h"
#import "SPAlbum+SMKAlbum.h"
#import "SPArtist+SMKArtist.h"
#import "SMKSpotifyPlayer.h"

@interface SMKSpotifyContentSource : SPSession <SMKContentSource>
/** This queue is used to sort and filter content before it's returned */
@property (nonatomic, readonly) dispatch_queue_t spotifyLocalQueue;
@end
