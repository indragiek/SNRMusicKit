//
//  SMKMPMediaAlbum.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-27.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "SMKAlbum.h"
#import "SMKArtworkObject.h"

@interface SMKMPMediaAlbum : NSObject <SMKAlbum, SMKArtworkObject>
@property (nonatomic, strong) MPMediaItemCollection *representedObject;
@property (nonatomic, assign, readonly) id<SMKContentSource> contentSource;

// SMKAlbum @optional
@property (nonatomic, assign, readonly) NSUInteger releaseYear;
@property (nonatomic, assign, readonly) NSUInteger rating;
@property (nonatomic, assign, readonly) NSTimeInterval duration;
@end
