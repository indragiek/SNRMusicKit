//
//  SMKMPMediaContentSource.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-24.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMKContentSource.h"
#import "SMKMPMediaPredicate.h"
#import "SMKMPMediaPlaylist.h"
#import "SMKMPMediaTrack.h"
#import "SMKMPMediaAlbum.h"
#import "SMKMPMediaArtist.h"

@interface SMKMPMediaContentSource : NSObject <SMKContentSource>
@property (nonatomic, readonly) dispatch_queue_t queryQueue;
@end
