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
@property (nonatomic, assign, readwrite) NSUInteger indexOfCurrentTrack;
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
    if ([[self.currentPlayer class] supportsPreloading] && [self.currentPlayer preloadedTrack]) {
        [self.currentPlayer skipToPreloadedTrack];
        self.indexOfCurrentTrack++;
    } else {
        NSUInteger nextIndex = self.indexOfCurrentTrack + 1;
        if (nextIndex < [self countOfItems])
            [self _beginPlayingItemAtIndex:nextIndex];
    }
    [self _recalculateIndexOfCurrentTrack];
}

- (IBAction)previous:(id)sender
{
    
}

- (IBAction)seekForward:(id)sender
{
    [self.currentPlayer seekForward];
}

- (IBAction)seekBackward:(id)sender
{
    [self.currentPlayer seekBackward];
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
    id<SMKPlayer> player = [[track playerClass] new];
    NSLog(@"now playing %@ with %@", [track name], player);
    self.currentPlayer = player;
    __weak SMKQueueController *weakSelf = self;
    [player playTrack:track completionHandler:^(NSError *error) {
        SMKQueueController *strongSelf = weakSelf;
        if (error) {
            SMKGenericErrorLog([NSString stringWithFormat:@"Error playing track %@", track], error);
            [strongSelf removeObjectFromItemsAtIndex:index];
            strongSelf.currentPlayer = nil;
            if (index < [strongSelf countOfItems])
                [strongSelf _beginPlayingItemAtIndex:index];
        } else {
            [strongSelf _recalculateIndexOfCurrentTrack];
        }
    }];
    [player setFinishedTrackBlock:^(id<SMKPlayer> player, id<SMKTrack> track, NSError *error) {
        SMKQueueController *strongSelf = weakSelf;
        [strongSelf next:nil];
    }];
}

- (void)_recalculateIndexOfCurrentTrack
{
    self.indexOfCurrentTrack = [self _indexOfTrack:self.currentTrack];
}
@end

@implementation SMKQueueItem
@end
