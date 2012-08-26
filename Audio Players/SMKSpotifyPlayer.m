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

@interface SMKSpotifyPlayer ()
@property (nonatomic, strong) id<SMKTrack> oldCurrentTrack;
@property (nonatomic, strong, readwrite) id<SMKTrack> preloadedTrack;
@end

@implementation SMKSpotifyPlayer

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
    id newValue = [change valueForKey:NSKeyValueChangeNewKey];
    if ([keyPath isEqualToString:@"playbackSession.playing"] && object == self) {
        [self willChangeValueForKey:@"playing"];
        _playing = [newValue boolValue];
        [self didChangeValueForKey:@"playing"];
        if (context != NULL)
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    } else if ([keyPath isEqualToString:@"trackPosition"] && object == self) {
        [self willChangeValueForKey:@"playbackTime"];
        _playbackTime = [newValue doubleValue];
        [self didChangeValueForKey:@"playbackTime"];
    } else if ([keyPath isEqualToString:@"currentTrack"]) {
        if (!SMKObjectIsValid(newValue)) {
            if (self.finishedTrackBlock)
                self.finishedTrackBlock(self, self.oldCurrentTrack, nil);
            self.oldCurrentTrack = nil;
        } else {
            self.preloadedTrack = nil;
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - SMKPlayer

+ (NSSet *)supportedContentSourceClasses
{
    return [NSSet setWithObject:NSStringFromClass([SMKSpotifyContentSource class])];
}

+ (BOOL)supportsPreloading
{
    return YES;
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

- (void)playTrack:(id<SMKTrack>)track completionHandler:(void (^)(NSError *))handler
{
    __weak SMKSpotifyPlayer *weakSelf = self;
    [self playTrack:(SPTrack *)track callback:^(NSError *error) {
        SMKSpotifyPlayer *strongSelf = weakSelf;
        if (!error)
            strongSelf.oldCurrentTrack = track;
        if (handler)
            handler(error);
    }];
}

- (void)preloadTrack:(id<SMKTrack>)track completionHandler:(void(^)(NSError *error))handler
{
    __weak SMKSpotifyPlayer *weakSelf = self;
    [self.playbackSession preloadTrackForPlayback:(SPTrack *)track callback:^(NSError *error) {
        SMKSpotifyPlayer *strongSelf = weakSelf;
        if (!error)
            strongSelf.preloadedTrack = track;
        if (handler)
            handler(error);
    }];
}

- (void)skipToPreloadedTrack
{
    [self playTrack:self.preloadedTrack completionHandler:nil];
}

#pragma mark - Accessors

- (void)setVolume:(float)volume
{
    [self willChangeValueForKey:@"volume"];
    [super setVolume:volume];
    [self didChangeValueForKey:@"volume"];
}
@end
