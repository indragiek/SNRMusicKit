//
//  AppDelegate.m
//  SpotifyExampleMac
//
//  Created by Indragie Karunaratne on 2012-08-25.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@property (nonatomic, strong) SMKSpotifyPlayer *audioPlayer;
@end

@implementation AppDelegate {
    SMKSpotifyContentSource *_source;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSString *credentialsFolder = [[NSHomeDirectory() stringByAppendingPathComponent:@"Desktop"] stringByAppendingPathComponent:@"credentials"];
    NSString *username = [NSString stringWithContentsOfFile:[credentialsFolder stringByAppendingPathComponent:@"spotify_username.txt"] encoding:NSUTF8StringEncoding error:nil];
    NSString *password = [NSString stringWithContentsOfFile:[credentialsFolder stringByAppendingPathComponent:@"spotify_password.txt"] encoding:NSUTF8StringEncoding error:nil];
    NSData *key = [NSData dataWithContentsOfFile:[credentialsFolder stringByAppendingPathComponent:@"spotify_appkey.key"]];
    _source = [[SMKSpotifyContentSource alloc] initWithApplicationKey:key userAgent:@"com.indragie.SNRMusicKit" loadingPolicy:SPAsyncLoadingImmediate error:nil];
    [_source attemptLoginWithUserName:username password:password];
    [_source setDelegate:self];
    [_source setUsingVolumeNormalization:YES];
    [_source fetchPlaylistsWithSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]
                                     batchSize:0
                                    fetchLimit:0
                                     predicate:nil
                             completionHandler:^(NSArray *playlists, NSError *error) {
        self.playlists = playlists;
    }];
    self.audioPlayer = [[SMKSpotifyPlayer alloc] initWithPlaybackSession:_source];
    self.audioPlayer.volume = 0.5f;
    [self.audioPlayer setFinishedTrackBlock:^(id<SMKPlayer> player, id<SMKTrack> track, NSError *error) {
        NSLog(@"Player %@ finished track %@ with error %@", player, track, error);
    }];
    [self.tracksTableView setTarget:self];
    [self.tracksTableView setDoubleAction:@selector(playTrack:)];
}

#pragma mark - NSTableViewDelegate

- (void)tableViewSelectionDidChange:(NSNotification *)notification
{
    NSTableView *tableView = [notification object];
    if (tableView == self.playlistsTableView) {
        NSInteger selectedRow = [tableView selectedRow];
        if (selectedRow != -1) {
            id<SMKPlaylist> playlist = [self.playlists objectAtIndex:selectedRow];
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
        id<SMKTrack> track = [self.tracks objectAtIndex:selectedRow];
        [self.audioPlayer playTrack:track completionHandler:^(NSError *error) {
            if (error)
                NSLog(@"Error playing track %@: %@, %@", track, error, [error userInfo]);
        }];
    }
}

#pragma mark - SPSessionDelegate

-(void)sessionDidLoginSuccessfully:(SPSession *)aSession
{
    NSLog(@"Successful login.");
}

- (void)session:(SPSession *)aSession didFailToLoginWithError:(NSError *)error
{
    NSLog(@"Failed login: %@ %@", error, [error userInfo]);
}
@end
