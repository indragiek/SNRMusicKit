//
//  DetailViewController.h
//  MPMediaLibraryExample
//
//  Created by Indragie Karunaratne on 2012-08-27.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
