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
@end

@implementation SMKAVQueuePlayer {
    BOOL _playing;
}
@synthesize playing = _playing;
@dynamic volume;

- (id)init
{
    if ((self = [super init])) {
        [self addObserver:self forKeyPath:@"rate" options:NSKeyValueObservingOptionNew context:NULL];
        [self addObserver:self forKeyPath:@"currentItem" options:NSKeyValueObservingOptionNew context:NULL];
        __weak SMKAVQueuePlayer *weakSelf = self;
        [self addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(1.f, 1.f) queue:NULL usingBlock:^(CMTime time) {
            SMKAVQueuePlayer *strongSelf = weakSelf;
            strongSelf.playbackTime = (NSTimeInterval)CMTimeGetSeconds(time);
        }];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeTimeObserver:self];
    [self removeObserver:self forKeyPath:@"rate"];
}

#pragma mark - SMKPlayer

+ (NSSet*)supportedContentSourceClasses
{
    return [NSSet setWithObjects:NSStringFromClass([SMKiTunesContentSource class]), nil];
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
    return [(SMKAVPlayerItem *)self.currentItem SMK_track];
}

- (void)playTrack:(id<SMKTrack>)track completionHandler:(void(^)(NSError *error))handler
{
    [self pause];
    [self removeAllItems];
    SMKAVPlayerItem *item = [self _playerItemForTrack:track];
    [self insertItem:item afterItem:nil];
    [self play];
    if (handler) handler(self.error);
}

- (void)seekToPlaybackTime:(NSTimeInterval)time
{
    [self seekToTime:CMTimeMakeWithSeconds(time, self.rate)];
}

- (void)seekBackward
{
    NSTimeInterval newTime = CMTimeGetSeconds([self currentTime]) - self.seekTimeInterval;
    [self seekToPlaybackTime:newTime];
}

- (void)seekForward
{
    NSTimeInterval newTime = CMTimeGetSeconds([self currentTime]) + self.seekTimeInterval;
    [self seekToPlaybackTime:newTime];
}

- (void)preloadTrack:(id<SMKTrack>)track completionHandler:(void (^)(NSError *))handler
{
    if ([self.items count] == 2) {
        id<SMKTrack> preloadedTrack = [(SMKAVPlayerItem *)[[self items] objectAtIndex:1] SMK_track];
        handler([NSError SMK_errorWithCode:SMKPlayerErrorTrackAlreadyPreloaded description:[NSString stringWithFormat:@"The following track is already preloaded: %@. This track must begin playing before you can preload another one.", preloadedTrack]]);
    }
    SMKAVPlayerItem *item = [self _playerItemForTrack:track];
    [self insertItem:item afterItem:[self currentItem]];
    if (handler) { handler(self.error); }
}

- (id<SMKTrack>)preloadedTrack
{
    if ([self.items count] == 2)
        return [self.items objectAtIndex:1];
    return nil;
}

- (void)skipToPreloadedTrack
{
    [self advanceToNextItem];
}


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
    if (object == self && [keyPath isEqualToString:@"rate"]) {
        float newValue = [[change valueForKey:NSKeyValueChangeNewKey] floatValue];
        [self willChangeValueForKey:@"playing"];
        _playing = newValue >= 1.0;
        [self didChangeValueForKey:@"playing"];
    }
}

@end
