//
//  SMKAVAudioPlayer.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-21.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SMKAVAudioPlayer.h"
#import "SMKTrack.h"
#import "SMKiTunesContentSource.h"

#import "NSError+SMKAdditions.h"

@interface SMKAVAudioPlayer ()
@property (nonatomic, strong, readwrite) AVAudioPlayer *currentPlayer;
@end

@implementation SMKAVAudioPlayer {
    AVAudioPlayer *_preloadedPlayer;
    id<SMKTrack> _currentTrack;
    id<SMKTrack> _preloadedTrack;
    NSTimeInterval _playbackTime;
    BOOL _playing;
}
@synthesize playbackTime = _playbackTime;
@synthesize playing = _playing;

- (void)dealloc
{
    [self _removePlayerObservers];
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
    return _currentTrack;
}

- (void)setVolume:(float)volume
{
    if (_volume != volume) {
        _volume = volume;
        self.currentPlayer.volume = volume;
        _preloadedPlayer.volume = volume;
    }
}

- (void)playTrack:(id<SMKTrack>)track completionHandler:(void(^)(NSError *error))handler
{
    NSError *error = nil;
    self.currentPlayer = [self _playerForTrack:track error:&error];
    self.currentPlayer.volume = self.volume;
    [self _delegateWillStartPlaying];
    [self.currentPlayer play];
    if (handler) handler(error);
}

- (void)pause
{
    [self.currentPlayer pause];
}

- (void)resume
{
    [self.currentPlayer play];
}

- (void)seekToPlaybackTime:(NSTimeInterval)time
{
    [self.currentPlayer setCurrentTime:time];
}

- (void)seekBackward
{
    NSTimeInterval newTime = [self.currentPlayer currentTime] - self.seekTimeInterval;
    [self seekToPlaybackTime:newTime];
}

- (void)seekForward
{
    NSTimeInterval newTime = [self.currentPlayer currentTime] + self.seekTimeInterval;
    [self seekToPlaybackTime:newTime];
}

- (void)preloadTrack:(id<SMKTrack>)track completionHandler:(void (^)(NSError *))handler
{
    if (_preloadedTrack) {
        handler([NSError SMK_errorWithCode:SMKPlayerErrorTrackAlreadyPreloaded description:[NSString stringWithFormat:@"The following track is already preloaded: %@. This track must begin playing before you can preload another one.", _preloadedTrack]]);
    }
    NSError *error = nil;
    _preloadedPlayer = [self _playerForTrack:track error:&error];
    if (_preloadedPlayer && !error) {
        _preloadedPlayer.volume = self.volume;
        [_preloadedPlayer prepareToPlay];
        _preloadedTrack = track;
    }
    if (handler) { handler(error); }
}

- (id<SMKTrack>)preloadedTrack
{
    return _preloadedTrack;
}

- (void)skipToPreloadedTrack
{
    if (!_preloadedPlayer)
        return;
    self.currentPlayer = _preloadedPlayer;
    [self _delegateWillStartPlaying];
    [self.currentPlayer play];
    _preloadedPlayer = nil;
    _preloadedTrack = nil;
}

#pragma mark - Accessors

- (void)setCurrentPlayer:(AVAudioPlayer *)currentPlayer
{
    if (_currentPlayer != currentPlayer) {
        [_currentPlayer stop];
        [self _removePlayerObservers];
        _currentPlayer = currentPlayer;
        [_currentPlayer setDelegate:self];
        [_currentPlayer addObserver:self forKeyPath:@"playing" options:NSKeyValueObservingOptionNew context:NULL];
        [_currentPlayer addObserver:self forKeyPath:@"currentTime" options:NSKeyValueObservingOptionNew context:NULL];
    }
}

#pragma mark - Player Specific API

- (AVAudioPlayer *)audioPlayer
{
    return self.currentPlayer;
}

#pragma mark - AVAudioPlayerDelegate

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
    SMKGenericErrorLog([NSString stringWithFormat:@"Decoding error for track %@", _currentTrack], error);
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if ([self.delegate respondsToSelector:@selector(playerDidFinishPlaying:)]) {
        [self.delegate playerDidFinishPlaying:self];
    }
    _currentTrack = nil;
    self.currentPlayer = nil;
    [self skipToPreloadedTrack];
}

#pragma mark - Private

- (void)_removePlayerObservers
{
    [_currentPlayer removeObserver:self forKeyPath:@"playing"];
    [_currentPlayer removeObserver:self forKeyPath:@"currentTime"];
}

- (void)_delegateWillStartPlaying
{
    if ([self.delegate respondsToSelector:@selector(playerWillStartPlaying:)]) {
        [self.delegate playerWillStartPlaying:self];
    }
}

- (AVAudioPlayer *)_playerForTrack:(id<SMKTrack>)track error:(NSError **)error
{
    if (self.loadFilesInMemory) {
        NSData *data = [NSData dataWithContentsOfURL:[track playbackURL]];
        return [[AVAudioPlayer alloc] initWithData:data error:error];
    } else {
        return [[AVAudioPlayer alloc] initWithContentsOfURL:[track playbackURL] error:error];
    }
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object != _currentPlayer)
        return;
    id newValue = [change valueForKey:NSKeyValueChangeNewKey];
    if ([keyPath isEqualToString:@"playing"]) {
        [self willChangeValueForKey:@"playing"];
        _playing = [newValue boolValue];
        [self didChangeValueForKey:@"playing"];
    } else if ([keyPath isEqualToString:@"currentTime"]) {
        [self willChangeValueForKey:@"playbackTime"];
        _playbackTime = [newValue floatValue];
        [self didChangeValueForKey:@"playbackTime"];
    }
}
@end
