//
//  AppDelegate.h
//  SpotifyExampleMac
//
//  Created by Indragie Karunaratne on 2012-08-25.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <SNRMusicKitMac/SMKSpotifyContentSource.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, SPSessionDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (nonatomic, weak) IBOutlet NSTableView *playlistsTableView;
@property (nonatomic, weak) IBOutlet NSTableView *tracksTableView;

@property (nonatomic, strong) NSArray *playlists;
@property (nonatomic, strong) NSArray *tracks;
@property (nonatomic, strong, readonly) SMKSpotifyPlayer *audioPlayer;
@end
