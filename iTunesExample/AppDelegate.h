//
//  AppDelegate.h
//  iTunesExample
//
//  Created by Indragie Karunaratne on 2012-08-23.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <SNRMusicKitMac/SMKAVAudioPlayer.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, NSTableViewDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, weak) IBOutlet NSTableView *playlistsTableView;
@property (nonatomic, weak) IBOutlet NSTableView *tracksTableView;

@property (nonatomic, strong) NSArray *playlists;
@property (nonatomic, strong) NSArray *tracks;
@property (nonatomic, strong, readonly) SMKAVAudioPlayer *audioPlayer;
@end
