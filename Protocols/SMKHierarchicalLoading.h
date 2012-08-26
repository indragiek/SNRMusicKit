//
//  SMKHierarchicalLoading.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-25.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SMKHierarchicalLoading <NSObject>
@required
/**
 This method should enter the passed group, asynchronously load itself, then call this 
 method on all of its children to trigger a "chain reaction" to load all the items. 
 Once it has called the method on its children, it can safely leave the group. 
 Objects at the very end of the hierarchy should add themselves to the passed array.
 @param group The group to enter and leave
 @param array Array for objects at the end of the hierarchy to add themselves to
 */
- (void)loadHierarchy:(dispatch_group_t)group array:(NSMutableArray *)array;
@end
