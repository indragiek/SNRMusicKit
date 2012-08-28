//
//  SMKAVQueuePlayer.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-23.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SMKAVQueuePlayer.h"
#import "SMKiTunesContentSource.h"
#import "SMKAVPlayerItem.h"
#import "SMKTrack.h"
#import "SMKErrorCodes.h"
#import "NSError+SMKAdditions.h"

#import <CoreMedia/CoreMedia.h>

@interface SMKAVQueuePlayer ()
@property (nonatomic, assign, readwrite) NSTimeInterval playbackTime;
@property (nonatomic, strong, readwrite) AVQueuePlayer *audioPlayer;
@end

@implementation SMKAVQueuePlayer
#if !TARGET_OS_IPHONE
@synthesize volume = _volume;
#endif

- (id)init
{
    if ((self = [super init])) {
        self.audioPlayer = [AVQueuePlayer queuePlayerWithItems:nil];
        [self addObserver:self forKeyPath:@"audioPlayer.rate" options:NSKeyValueObservingOptionNew context:NULL];
        __weak SMKAVQueuePlayer *weakSelf = self;
        [self.audioPlayer addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(1.f, 1.f) queue:NULL usingBlock:^(CMTime time) {
            SMKAVQueuePlayer *strongSelf = weakSelf;
            strongSelf.playbackTime = (NSTimeInterval)CMTimeGetSeconds(time);
        }];
        self.seekTimeInterval = SMKPlayerDefaultSeekTimeInterval;
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_audioPlayer removeTimeObserver:self];
    [self removeObserver:self forKeyPath:@"audioPlayer.rate"];
}

#pragma mark - SMKPlayer

+ (NSSet*)supportedContentSourceClasses
{
    return [NSSet setWithObjects:NSClassFromString(@"SMKiTunesContentSource"), NSClassFromString(@"SMKMPMediaContentSource"), nil];
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

- (id<SMKTrack>)currentTrack
{
    return [(SMKAVPlayerItem *)self.audioPlayer.currentItem SMK_track];
}

- (void)pause
{
    [self.audioPlayer pause];
}

- (void)play
{
    [self.audioPlayer play];
}

- (void)playTrack:(id<SMKTrack>)track completionHandler:(void(^)(NSError *error))handler
{
    [self.audioPlayer pause];
    [self.audioPlayer removeAllItems];
    SMKAVPlayerItem *item = [self _playerItemForTrack:track];
    [self.audioPlayer insertItem:item afterItem:nil];
    [self.audioPlayer play];
    if (handler) handler(self.audioPlayer.error);
}

- (void)seekToPlaybackTime:(NSTimeInterval)time
{
    [self.audioPlayer seekToTime:CMTimeMakeWithSeconds(time, self.audioPlayer.rate)];
}

- (void)seekBackward
{
    NSTimeInterval newTime = CMTimeGetSeconds(self.audioPlayer.currentTime) - self.seekTimeInterval;
    [self seekToPlaybackTime:newTime];
}

- (void)seekForward
{
    NSTimeInterval newTime = CMTimeGetSeconds(self.audioPlayer.currentTime) + self.seekTimeInterval;
    [self seekToPlaybackTime:newTime];
}

- (void)preloadTrack:(id<SMKTrack>)track completionHandler:(void (^)(NSError *))handler
{
    if ([self.audioPlayer.items count] == 2) {
        id<SMKTrack> preloadedTrack = [(SMKAVPlayerItem *)[self.audioPlayer.items objectAtIndex:1] SMK_track];
        handler([NSError SMK_errorWithCode:SMKPlayerErrorTrackAlreadyPreloaded description:[NSString stringWithFormat:@"The following track is already preloaded: %@. This track must begin playing before you can preload another one.", preloadedTrack]]);
    }
    SMKAVPlayerItem *item = [self _playerItemForTrack:track];
    [self.audioPlayer insertItem:item afterItem:self.audioPlayer.currentItem];
    if (handler) { handler(self.audioPlayer.error); }
}

- (id<SMKTrack>)preloadedTrack
{
    if ([self.audioPlayer.items count] == 2)
        return [self.audioPlayer.items objectAtIndex:1];
    return nil;
}

- (void)skipToPreloadedTrack
{
    [self.audioPlayer advanceToNextItem];
}

#if !TARGET_OS_IPHONE
- (void)setVolume:(float)volume
{
    self.audioPlayer.volume = volume;
}

- (float)volume
{
    return self.audioPlayer.volume;
}
#endif

#pragma mark - Private

- (SMKAVPlayerItem *)_playerItemForTrack:(id<SMKTrack>)track
{
    SMKAVPlayerItem *item = [[SMKAVPlayerItem alloc] initWithURL:[track playbackURL]];
    [item setSMK_track:track];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(_itemDidPlayToEndTime:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [nc addObserver:self selector:@selector(_itemDidFailToPlayToEndTime:) name:AVPlayerItemFailedToPlayToEndTimeNotification object:nil];
    return item;
}

- (void)_removeObserversForItem:(AVPlayerItem *)item
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:item];
    [nc removeObserver:self name:AVPlayerItemFailedToPlayToEndTimeNotification object:item];
}

#pragma mark - Notifications

- (void)_itemDidPlayToEndTime:(NSNotification *)notification
{
    id object = [notification object];
    [self _removeObserversForItem:object];
    if (self.finishedTrackBlock) {
        id<SMKTrack> track = [object SMK_track];
        self.finishedTrackBlock(self, track, nil);
    }
}

- (void)_itemDidFailToPlayToEndTime:(NSNotification *)notification
{
    id object = [notification object];
    [self _removeObserversForItem:object];
    if (self.finishedTrackBlock) {
        NSError *error = [[notification userInfo] valueForKey:AVPlayerItemFailedToPlayToEndTimeErrorKey];
        id<SMKTrack> track = [object SMK_track];
        self.finishedTrackBlock(self, track, error);
    }
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self && [keyPath isEqualToString:@"audioPlayer.rate"]) {
        float newValue = [[change valueForKey:NSKeyValueChangeNewKey] floatValue];
        [self willChangeValueForKey:@"playing"];
        _playing = newValue >= 1.0;
        [self didChangeValueForKey:@"playing"];
    }
}

@end
