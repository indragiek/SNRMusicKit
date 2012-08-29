//
//  SMKMPMusicPlayer.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-28.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SMKMPMusicPlayer.h"
#import "SMKMPMediaTrack.h"
#import "NSError+SMKAdditions.h"

@interface SMKMPMusicPlayer ()
@property (nonatomic, strong, readwrite) MPMusicPlayerController *audioPlayer;
@property (nonatomic, strong, readwrite) MPMusicPlayerController *preloadAudioPlayer;
@property (nonatomic, assign, readwrite) BOOL playing;
@property (nonatomic, strong) id<SMKTrack> oldCurrentTrack;
@property (nonatomic, strong) id<SMKTrack> preloadedTrack;
@end

@implementation SMKMPMusicPlayer
- (id)init
{
    if ((self = [super init])) {
        self.audioPlayer = [MPMusicPlayerController iPodMusicPlayer];
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(_playbackStateDidChange:) name:MPMusicPlayerControllerPlaybackStateDidChangeNotification object:self.audioPlayer];
        [nc addObserver:self selector:@selector(_nowPlayingItemDidChange:) name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification object:self.audioPlayer];
        [self.audioPlayer beginGeneratingPlaybackNotifications];
        self.audioPlayer.repeatMode = MPMusicRepeatModeNone;
        self.audioPlayer.shuffleMode = MPMusicShuffleModeOff;
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - SMKPlayer

+ (NSSet *)supportedContentSourceClasses
{
    return [NSSet setWithObject:NSClassFromString(@"SMKMPMediaContentSource")];
}

+ (BOOL)supportsPreloading
{
    return NO;
}

- (BOOL)supportsSeeking
{
    return YES;
}

- (id<SMKTrack>)currentTrack
{
    return self.oldCurrentTrack;
}

- (void)playTrack:(id<SMKTrack>)track completionHandler:(void(^)(NSError *error))handler
{
    if ([track isKindOfClass:[SMKMPMediaTrack class]]) {
        SMKMPMediaTrack *mediaTrack = (SMKMPMediaTrack *)track;
        MPMediaItem *mediaItem = mediaTrack.representedObject;
        MPMediaItemCollection *collection = [MPMediaItemCollection collectionWithItems:@[mediaItem]];
        [self.audioPlayer setQueueWithItemCollection:collection];
        [self.audioPlayer play];
        if (handler) { handler(nil); }
    } else if (handler) {
        NSError *error = [NSError SMK_errorWithCode:SMKPlayerErrorFailedToEnqueueTrack description:@"MPMusicPlayerController failed to play the track because the object was of the wrong type. Expected SMKMPMediaTrack"];
        handler(error);
    }
}

- (void)pause
{
    [self.audioPlayer pause];
}

- (void)play
{
    [self.audioPlayer play];
}

- (NSTimeInterval)playbackTime
{
    return self.audioPlayer.currentPlaybackTime;
}

+ (NSSet *)keyPathsForValuesAffectingPlaybackTime
{
    return [NSSet setWithObject:@"audioPlayer.currentPlaybackTime"];
}

- (void)seekToPlaybackTime:(NSTimeInterval)time
{
    self.audioPlayer.currentPlaybackTime = time;
}

- (void)seekBackward
{
    self.audioPlayer.currentPlaybackTime = self.audioPlayer.currentPlaybackTime - self.seekTimeInterval;
}

- (void)seekForward
{
    self.audioPlayer.currentPlaybackTime = self.audioPlayer.currentPlaybackTime + self.seekTimeInterval;
}

#pragma mark - Notifications

- (void)_playbackStateDidChange:(NSNotification *)notification
{
    self.playing = self.audioPlayer.playbackState == MPMusicPlaybackStatePlaying;
}

- (void)_nowPlayingItemDidChange:(NSNotification *)notification
{
    if (!self.audioPlayer.nowPlayingItem && self.finishedTrackBlock) {
        self.finishedTrackBlock(self, self.oldCurrentTrack, nil);
        self.oldCurrentTrack = nil;
    }
}
@end
