//
//  SMKQueueController.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-29.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SMKQueueController.h"

@interface SMKQueueItem : NSObject
@property (nonatomic, retain) id<SMKTrack> track;
@end

@interface SMKQueueController ()
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong, readwrite) id<SMKPlayer> currentPlayer;
@end

@implementation SMKQueueController

- (id)init
{
    if ((self = [super init])) {
        self.items = [NSMutableArray array];
    }
    return self;
}

- (id)initWithTracks:(NSArray *)tracks
{
    if ((self = [super init])) {
        NSArray *items = [self _queueItemsForTracks:tracks];
        self.items = [NSMutableArray arrayWithArray:items];
    }
    return self;
}

+ (instancetype)queueControllerWithTracks:(NSArray *)tracks
{
    return [[self alloc] initWithTracks:tracks];
}

#pragma mark - Queue

- (void)insertTrack:(id<SMKTrack>)newTrack afterTrack:(id<SMKTrack>)track
{
    if (!track) {
        [self.items addObjectsFromArray:[self _queueItemsForTracks:@[newTrack]]];
    } else {
        NSUInteger index = [self _indexOfTrack:track];
        if (index != NSNotFound)
            [self insertObject:newTrack inItemsAtIndex:index+1];
    }
}

- (void)removeAllTracks
{
    [self pause:nil];
    self.items = [NSMutableArray array];
}

- (void)removeTrack:(id<SMKTrack>)track
{
    NSUInteger index = [self _indexOfTrack:track];
    if (index == NSNotFound)
        return;
    if ([track isEqual:self.currentTrack]) {
        [self next:nil];
    }
    [self removeObjectFromItemsAtIndex:index];
}

#pragma mark - Accessors

- (NSUInteger)indexOfCurrentTrack
{
    return [self.items indexOfObject:self.currentTrack];
}

+ (NSSet *)keyPathsForValuesAffectingIndexOfCurrentTrack
{
    return [NSSet setWithObject:@"currentTrack"];
}

- (NSTimeInterval)playbackTime
{
    return [self.currentPlayer playbackTime];
}

- (void)seekToPlaybackTime:(NSTimeInterval)playbackTime
{
    [self.currentPlayer seekToPlaybackTime:playbackTime];
}

+ (NSSet *)keyPathsForValuesAffectingPlaybackTime
{
    return [NSSet setWithObject:@"currentPlayer.playbackTime"];
}

- (BOOL)playing
{
    return [self.currentPlayer playing];
}

+ (NSSet *)keyPathsForValuesAffectingPlaying
{
    return [NSSet setWithObject:@"currentPlayer.playing"];
}

- (NSArray *)tracks
{
    return [self.items valueForKey:@"track"];
}

+ (NSSet *)keyPathsForValuesAffectingTracks
{
    return [NSSet setWithObject:@"items"];
}

- (id<SMKTrack>)currentTrack
{
    return [self.currentPlayer currentTrack];
}

+ (NSSet *)keyPathsForValuesAffectingCurrentTrack
{
    return [NSSet setWithObject:@"currentPlayer.currentTrack"];
}

#pragma mark - Array Accessors

- (NSUInteger)countOfItems
{
    return [self.items count];
}

- (id)objectInItemsIndex:(NSUInteger)index
{
    return [self.items objectAtIndex:index];
}

- (void)insertObject:(id)obj inItemsAtIndex:(NSUInteger)index
{
    [self.items insertObject:obj atIndex:index];
}

- (void)removeObjectFromItemsAtIndex:(NSUInteger)index
{
    [self.items removeObjectAtIndex:index];
}

- (void)replaceObjectInItemsAtIndex:(NSUInteger)index withObject:(id)obj
{
    [self.items replaceObjectAtIndex:index withObject:obj];
}

#pragma mark - Playback

- (IBAction)play:(id)sender
{
    if (!self.currentPlayer && [self.items count]) {
        [self _beginPlayingItemAtIndex:0];
    }
    [self.currentPlayer play];
}

- (IBAction)pause:(id)sender
{
    [self.currentPlayer pause];
}

- (IBAction)playPause:(id)sender
{
    [self playing] ? [self pause:nil] : [self play:nil];
}

- (IBAction)next:(id)sender
{
    
}

- (IBAction)previous:(id)sender
{
    
}

- (IBAction)seekForward:(id)sender
{
    
}

- (IBAction)seekBackward:(id)sender
{
    
}

#pragma mark - Private

- (NSArray *)_queueItemsForTracks:(NSArray *)tracks
{
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:[tracks count]];
    [tracks enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        SMKQueueItem *item = [SMKQueueItem new];
        item.track = obj;
        [items addObject:item];
    }];
    return items;
}

- (NSUInteger)_indexOfTrack:(id<SMKTrack>)track
{
    __block NSUInteger index = NSNotFound;
    [self.items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([[obj track] isEqual:track]) {
            index = idx;
            *stop = YES;
        }
    }];
    return index;
}

- (void)_beginPlayingItemAtIndex:(NSUInteger)index
{
    id<SMKTrack> track = [[self.items objectAtIndex:index] track];
    self.currentPlayer = [[track playerClass] new];
    __weak SMKQueueController *weakSelf = self;
    [self.currentPlayer playTrack:track completionHandler:^(NSError *error) {
        if (error) {
            SMKQueueController *strongSelf = weakSelf;
            SMKGenericErrorLog([NSString stringWithFormat:@"Error playing track %@", track], error);
            [strongSelf removeObjectFromItemsAtIndex:index];
            strongSelf.currentPlayer = nil;
            if (index < [self.items count])
                [self _beginPlayingItemAtIndex:index];
        }
    }];
}
@end
