//
//  SMKSFBAudioPlayer.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-21.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SMKSFBAudioPlayer.h"
#import <SFBAudioEngine/AudioPlayer.h>
#import <SFBAudioEngine/AudioDecoder.h>
#import <SFBAudioEngine/InputSource.h>
#import <AudioUnit/AudioUnit.h>
#import <CoreAudio/CoreAudio.h>

#include "TargetConditionals.h"

#import "NSError+SMKAdditions.h"

// ========================================
// Player flags
// ========================================
enum {
	SMKPlayerFlagRenderingStarted		  = 1 << 0,
    SMKPlayerFlagRenderingFinished        = 1 << 1,
    SMKPlayerFlagDecodingStarted          = 1 << 2,
    SMKPlayerFlagDecodingFinished         = 1 << 3
};

volatile static uint32_t _playerFlags = 0;

#if TARGET_OS_MAC
static AudioObjectPropertyAddress _outputAudioAddress = {
    kAudioHardwarePropertyDefaultSystemOutputDevice,
    kAudioObjectPropertyScopeGlobal,
    kAudioObjectPropertyElementMaster
};
#endif

#pragma mark -
#pragma mark Callbacks

static void renderingStarted(void *context, const AudioDecoder *decoder)
{
	OSAtomicTestAndSetBarrier(7 /* SMKPlayerFlagRenderingStarted */, &_playerFlags);
}

static void renderingFinished(void *context, const AudioDecoder *decoder)
{
	OSAtomicTestAndSetBarrier(6 /* SMKPlayerFlagRenderingFinished */, &_playerFlags);
}

static void decodingStarted(void *context, const AudioDecoder *decoder)
{
    OSAtomicTestAndSetBarrier(5 /* SMKPlayerFlagDecodingStarted */, &_playerFlags);
}

static void decodingFinished(void *context, const AudioDecoder *decoder)
{
    OSAtomicTestAndSetBarrier(4 /* SMKPlayerFlaDecodingFinished */, &_playerFlags);
}

@interface SMKSFBAudioPlayer ()
- (void)_setOutputDeviceID:(AudioDeviceID)deviceID;
- (void)_renderTimerFired:(NSTimer*)timer;
@end

#if TARGET_OS_MAC
static OSStatus systemOutputDeviceDidChange(AudioObjectID inObjectID, UInt32 inNumberAddresses, const AudioObjectPropertyAddress inAddresses[], void* refcon)
{
    AudioDeviceID currentDevice;
    UInt32 propsize = sizeof(AudioDeviceID);
    OSStatus err = AudioObjectGetPropertyData(kAudioObjectSystemObject, &_outputAudioAddress, 0, NULL, &propsize, &currentDevice);
    if (err == noErr) {
        SMKSFBAudioPlayer *player = (__bridge SMKSFBAudioPlayer*)refcon;
        [player _setOutputDeviceID:currentDevice];
    }
    return err;
}
#endif

@implementation SMKSFBAudioPlayer {
    AudioPlayer *_player;
    AudioUnit _equalizer;
    NSTimer *_renderTimer;
    
    id<SMKTrack> _currentTrack;
    id<SMKTrack> _preloadedTrack;
    
    BOOL _playWhenReady;
}
@synthesize delegate = _delegate;
@synthesize seekTimeInterval = _seekTimeInterval;

- (id)init
{
    if ((self = [super init])) {
        _player = new AudioPlayer;
        _player->AddEffect(kAudioUnitSubType_GraphicEQ, kAudioUnitManufacturer_Apple, 0, 0, &_equalizer);
        AudioUnitSetParameter(_equalizer, 10000, kAudioUnitScope_Global, 0, 0.0, 0); // 10 band EQ
        #if TARGET_OS_MAC
        AudioObjectAddPropertyListener(kAudioObjectSystemObject, &_outputAudioAddress, systemOutputDeviceDidChange, (__bridge void*)self);
        #endif
        AudioDecoder::SetAutomaticallyOpenDecoders(true);
        _renderTimer = [NSTimer timerWithTimeInterval:0.5f target:self selector:@selector(_renderTimerFired:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_renderTimer forMode:NSRunLoopCommonModes];
    }
    return self;
}

#pragma mark - SMKPlayer

+ (NSSet*)supportedContentSourceClasses
{
    return nil;
}

- (BOOL)supportsPreloading
{
    return YES;
}

- (BOOL)supportsAirPlay
{
    return NO;
}

- (BOOL)supportsSeeking
{
    return (BOOL)_player->SupportsSeeking();
}

- (id<SMKTrack>)currentTrack
{
    return _currentTrack;
}

- (float)volume
{
    Float32 volume = 0.0;
    _player->GetVolume(volume);
    return (float)volume;
}

- (void)setVolume:(float)volume
{
    _player->SetVolume(volume);
}

- (void)playTrack:(id<SMKTrack>)track completionHandler:(void(^)(NSError *error))handler
{
    NSURL *url = [track playbackURL];
    InputSource *inputSource = InputSource::CreateInputSourceForURL((__bridge CFURLRef)url, self.loadFilesInMemory ? InputSourceFlagLoadFilesInMemory : 0, nullptr);
    if (inputSource == nullptr) {
        handler([NSError SMK_errorWithCode:SKPlayerErrorFailedToCreateInputSource description:[NSString stringWithFormat:@"Failed to create input source for track: %@", track]]);
        return;
    }
	AudioDecoder *decoder = AudioDecoder::CreateDecoderForInputSource(inputSource);
	if (decoder == nullptr) {
        delete inputSource, inputSource = nullptr;
        handler([NSError SMK_errorWithCode:SKPlayerErrorFailedToCreateDecoder description:[NSString stringWithFormat:@"Failed to create decoder for track: %@", track]]);
        return;
    }
	decoder->SetRenderingStartedCallback(renderingStarted, (__bridge void*)self);
	decoder->SetRenderingFinishedCallback(renderingFinished, (__bridge void*)self);
    decoder->SetDecodingStartedCallback(decodingStarted, (__bridge void*)self);
    decoder->SetDecodingFinishedCallback(decodingFinished, (__bridge void*)self);
    _playWhenReady = YES;
	if ((_player->Enqueue(decoder)) == false) {
		delete decoder, decoder = nullptr;
        _playWhenReady = NO;
        handler([NSError SMK_errorWithCode:SKPlayerErrorFailedToEnqueueTrack description:[NSString stringWithFormat:@"Failed to create decoder for track: %@", track]]);
        return;
	}
    handler(nil);
}

- (void)pause
{
    _player->Pause();
}

- (void)resume
{
    if (!_playWhenReady)
        _player->Play();
}

- (BOOL)isPlaying
{
    return (BOOL)_player->IsPlaying();
}

- (NSTimeInterval)playbackTime
{
    CFTimeInterval time = 0.0;
    _player->GetCurrentTime(time);
    return (NSTimeInterval)time;
}

- (void)seekToPlaybackTime:(NSTimeInterval)time
{
    _player->SeekToTime((CFTimeInterval)time);
}

- (void)seekBackward
{
    _player->SeekBackward((CFTimeInterval)self.seekTimeInterval);
}

- (void)seekForward
{
    _player->SeekForward((CFTimeInterval)self.seekTimeInterval);
}

- (void)preloadTrack:(id<SMKTrack>)track completionHandler:(void (^)(NSError *))handler
{
    _preloadedTrack = track;
    [self playTrack:track completionHandler:^(NSError *error) {
        if (!error) {
            _preloadedTrack = track;
        } else {
            handler(error);
        }
    }];
}

- (id<SMKTrack>)preloadedTrack
{
    return _preloadedTrack;
}

- (void)skipToPreloadedTrack
{
    _player->SkipToNextTrack();
}

#pragma mark - Player Specific API

- (float)preGain
{
    Float32 preGain = 0.0;
    _player->GetPreGain(preGain);
    return (float)preGain;
}

- (void)setPreGain:(float)preGain
{
    _player->SetPreGain(preGain);
}

- (void)setEQValue:(float)value forEQBand:(int)band
{
    AudioUnitSetParameter(_equalizer, band, kAudioUnitScope_Global, 0, (Float32)value, 0);
}

#pragma mark - Private

- (void)_setOutputDeviceID:(AudioDeviceID)deviceID
{
    _player->SetOutputDeviceID(deviceID);
}

- (void)_renderTimerFired:(NSTimer*)timer
{
    if (SMKPlayerFlagRenderingStarted & _playerFlags) {
		OSAtomicTestAndClearBarrier(7 /* SMKPlayerFlagRenderingStarted */, &_playerFlags);
		if ([self.delegate respondsToSelector:@selector(playerWillStartPlaying:)]) {
            [self.delegate playerWillStartPlaying:self];
        }
	} else if (SMKPlayerFlagRenderingFinished & _playerFlags) {
		OSAtomicTestAndClearBarrier(6 /* SMKPlayerFlagRenderingFinished */, &_playerFlags);
		if ([self.delegate respondsToSelector:@selector(playerDidFinishPlaying:)]) {
            [self.delegate playerDidFinishPlaying:self];
        }
	} else if (SMKPlayerFlagDecodingStarted & _playerFlags) {
        OSAtomicTestAndClearBarrier(5 /* SMKPlayerFlagDecodingStarted */, &_playerFlags);
        if (_playWhenReady) {
            [self resume];
            _playWhenReady = NO;
        }
    }
    if ([self.delegate respondsToSelector:@selector(playerUpdateUserInteface:)]) {
        [self.delegate playerUpdateUserInteface:self];
    }
}

@end
