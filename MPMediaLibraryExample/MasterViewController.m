//
//  MasterViewController.m
//  MPMediaLibraryExample
//
//  Created by Indragie Karunaratne on 2012-08-27.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"
#import "SNRMusicKitiOS.h"

@interface MasterViewController ()
@property (nonatomic, strong) NSArray *playlists;
@end

@implementation MasterViewController {
    SMKMPMediaContentSource *_contentSource;
}

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _contentSource = [SMKMPMediaContentSource new];
    __weak MasterViewController *weakSelf = self;
    [_contentSource fetchPlaylistsWithSortDescriptors:nil predicate:nil completionHandler:^(NSArray *playlists, NSError *error) {
        MasterViewController *strongSelf = weakSelf;
        strongSelf.playlists = playlists;
        [strongSelf.tableView reloadData];
    }];
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.playlists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    id<SMKPlaylist> object = self.playlists[indexPath.row];
    cell.textLabel.text = [object name];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        id<SMKPlaylist> object = self.playlists[indexPath.row];
        self.detailViewController.detailItem = object;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        id<SMKPlaylist> object = self.playlists[indexPath.row];
        self.detailViewController.detailItem = object;
    }
}

@end
