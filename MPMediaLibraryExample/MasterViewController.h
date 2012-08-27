//
//  MasterViewController.h
//  MPMediaLibraryExample
//
//  Created by Indragie Karunaratne on 2012-08-27.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
