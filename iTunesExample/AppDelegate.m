//
//  AppDelegate.m
//  iTunesExample
//
//  Created by Indragie Karunaratne on 2012-08-23.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "AppDelegate.h"
#import <SNRMusicKitMac/SMKiTunesContentSource.h>

@interface AppDelegate ()
@property (nonatomic, strong) SMKAVAudioPlayer *audioPlayer;
@end

@implementation AppDelegate {
    SMKiTunesContentSource *_contentSource;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    _contentSource = [SMKiTunesContentSource new];
    self.audioPlayer = [SMKAVAudioPlayer new];
    self.audioPlayer.volume = 0.5f;
    [self.tracksTableView setTarget:self];
    [self.tracksTableView setDoubleAction:@selector(playTrack:)];
    NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    [_contentSource fetchPlaylistsWithSortDescriptors:sortDescriptors batchSize:20 fetchLimit:0 predicate:nil completionHandler:^(NSArray *playlists, NSError *error) {
        self.playlists = playlists;
    }];
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification
{
    NSTableView *tableView = [notification object];
    if (tableView == self.playlistsTableView) {
        NSInteger selectedRow = [tableView selectedRow];
        if (selectedRow != -1) {
            SMKiTunesPlaylist *playlist = [self.playlists objectAtIndex:selectedRow];
            NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
            [playlist fetchTracksWithSortDescriptors:sortDescriptors predicate:nil batchSize:20 fetchlimit:0 completionHandler:^(NSArray *tracks, NSError *error) {
                self.tracks = tracks;
            }];
        }
    }
}

- (void)playTrack:(id)sender
{
    NSInteger selectedRow = [sender selectedRow];
    if (selectedRow != -1) {
        SMKiTunesTrack *track = [self.tracks objectAtIndex:selectedRow];
        [self.audioPlayer playTrack:track completionHandler:^(NSError *error) {
            if (error)
                NSLog(@"Error playing track %@: %@, %@", track, error, [error userInfo]);
        }];
    }
}
@end
