//
//  SMKMPMediaTrack.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-27.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "SMKTrack.h"

@interface SMKMPMediaTrack : NSObject <SMKTrack>
@property (nonatomic, strong) MPMediaItem *representedObject;
@property (nonatomic, assign, readonly) id<SMKContentSource> contentSource;

// SMKTrack @optional
@property (nonatomic, strong, readonly) NSString *composer;
@property (nonatomic, assign, readonly) NSUInteger trackNumber;
@property (nonatomic, assign, readonly) NSUInteger discNumber;
@property (nonatomic, assign, readonly) NSUInteger playCount;
@property (nonatomic, strong, readonly) NSString *lyrics;
@property (nonatomic, assign, readonly) NSUInteger rating;
@property (nonatomic, strong, readonly) NSDate *lastPlayedDate;
@property (nonatomic, strong, readonly) NSURL *playbackURL;
@end
