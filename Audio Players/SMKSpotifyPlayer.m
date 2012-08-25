//
//  SMKSpotifyPlayer.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-25.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SMKSpotifyPlayer.h"
#import "SMKSpotifyContentSource.h"
#import "SPTrack+SMKTrack.h"

@implementation SMKSpotifyPlayer {
    id<SMKTrack> _oldCurrentTrack;
}

- (id)initWithPlaybackSession:(SPSession *)aSession
{
    if ((self = [super initWithPlaybackSession:aSession])) {
        self.seekTimeInterval = SMKPlayerDefaultSeekTimeInterval;
        [self addObserver:self forKeyPath:@"playbackSession.playing" options:NSKeyValueObservingOptionNew context:NULL];
        [self addObserver:self forKeyPath:@"trackPosition" options:NSKeyValueObservingOptionNew context:NULL];
        [self addObserver:self forKeyPath:@"currentTrack" options:NSKeyValueObservingOptionNew context:NULL];
    }
    return self;
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"playbackSession.playing"];
    [self removeObserver:self forKeyPath:@"trackPosition"];
    [self removeObserver:self forKeyPath:@"currentTrack"];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    id newValue = [change valueForKey:NSKeyValueChangeNewKey];
    if ([keyPath isEqualToString:@"playbackSession.playing"] && object == self) {
        [self willChangeValueForKey:@"playing"];
        _playing = [newValue boolValue];
        [self didChangeValueForKey:@"playing"];
    } else if ([keyPath isEqualToString:@"trackPosition"] && object == self) {
        [self willChangeValueForKey:@"playbackTime"];
        _playbackTime = [newValue doubleValue];
    } else if ([keyPath isEqualToString:@"currentTrack"]) {
        if (!newValue) {
            if (self.finishedTrackBlock)
                self.finishedTrackBlock(self, _oldCurrentTrack, nil);
            _oldCurrentTrack = nil;
        }
    }
}

#pragma mark - SMKPlayer

+ (NSSet *)supportedContentSourceClasses
{
    return [NSSet setWithObject:NSStringFromClass([SMKSpotifyContentSource class])];
}

+ (BOOL)supportsPreloading
{
    return NO;
}

+ (BOOL)supportsAirPlay
{
    return NO;
}

- (BOOL)supportsSeeking
{
    return YES;
}

- (void)pause
{
    [self setIsPlaying:NO];
}

- (void)play
{
    [self setIsPlaying:YES];
}

- (void)seekToPlaybackTime:(NSTimeInterval)time
{
    [self seekToTrackPosition:time];
}

- (void)seekBackward
{
    NSTimeInterval newTime = [self trackPosition] - self.seekTimeInterval;
    [self seekToTrackPosition:newTime];
}

- (void)seekForward
{
    NSTimeInterval newTime = [self trackPosition] + self.seekTimeInterval;
    [self seekToTrackPosition:newTime];
}

- (void)playTrack:(SPTrack *)aTrack callback:(SPErrorableOperationCallback)block
{
    [super playTrack:aTrack callback:block];
    _oldCurrentTrack = aTrack;
}

- (void)playTrack:(id<SMKTrack>)track completionHandler:(void (^)(NSError *))handler
{
    [self playTrack:(SPTrack *)track callback:handler];
}
@end
