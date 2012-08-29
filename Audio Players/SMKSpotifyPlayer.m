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
@property (nonatomic, strong, readwrite) SPPlaybackManager *audioPlayer;
@end

@implementation SMKSpotifyPlayer

- (id)initWithPlaybackSession:(SPSession *)aSession
{
    if ((self = [super init])) {
        self.audioPlayer = [[SPPlaybackManager alloc] initWithPlaybackSession:aSession];
        self.seekTimeInterval = SMKPlayerDefaultSeekTimeInterval;
        [self.audioPlayer addObserver:self forKeyPath:@"currentTrack" options:NSKeyValueObservingOptionNew context:NULL];
    }
    return self;
}

- (void)dealloc
{
    [_audioPlayer removeObserver:self forKeyPath:@"currentTrack"];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"currentTrack"] && object == self.audioPlayer) {
        if (!SMKObjectIsValid([change valueForKey:NSKeyValueChangeNewKey])) {
            if (self.finishedTrackBlock)
                self.finishedTrackBlock(self, self.oldCurrentTrack, nil);
            self.oldCurrentTrack = nil;
        } else {
            self.preloadedTrack = nil;
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
    return YES;
}

- (BOOL)supportsSeeking
{
    return YES;
}

- (id<SMKTrack>)currentTrack
{
    return [self.audioPlayer currentTrack];
}

- (void)pause
{
    [self.audioPlayer setIsPlaying:NO];
}

- (void)play
{
    [self.audioPlayer setIsPlaying:YES];
}

- (void)seekToPlaybackTime:(NSTimeInterval)time
{
    [self.audioPlayer seekToTrackPosition:time];
}

- (void)seekBackward
{
    NSTimeInterval newTime = [self.audioPlayer trackPosition] - self.seekTimeInterval;
    [self.audioPlayer seekToTrackPosition:newTime];
}

- (void)seekForward
{
    NSTimeInterval newTime = [self.audioPlayer trackPosition] + self.seekTimeInterval;
    [self.audioPlayer seekToTrackPosition:newTime];
}

- (void)playTrack:(id<SMKTrack>)track completionHandler:(void (^)(NSError *))handler
{
    __weak SMKSpotifyPlayer *weakSelf = self;
    [self.audioPlayer playTrack:(SPTrack *)track callback:^(NSError *error) {
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
    [self.audioPlayer.playbackSession preloadTrackForPlayback:(SPTrack *)track callback:^(NSError *error) {
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
    [self.audioPlayer setVolume:volume];
}

- (float)volume
{
    return [self.audioPlayer volume];
}

+ (NSSet *)keyPathsForValuesAffectingVolume
{
    return [NSSet setWithObject:@"audioPlayer.volume"];
}

+ (NSSet *)keyPathsForValuesAffectingPlaying
{
    return [NSSet setWithObject:@"audioPlayer.playbackSession.playing"];
}

+ (NSSet *)keyPathsForValuesAffectingPlaybackTime
{
    return [NSSet setWithObject:@"audioPlayer.trackPosition"];
}

+ (NSSet *)keyPathsForValuesAffectingCurrentTrack
{
    return [NSSet setWithObject:@"audioPlayer.currentTrack"];
}
@end
