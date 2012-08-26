//
//  NSMutableArray+SMKAdditions.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-25.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (SMKAdditions)
/**
 @param sortDescriptors Array of sort descriptors to sort the array with
 @param predicate NSPredicate to filter the array
 */
- (void)SMK_processWithSortDescriptors:(NSArray *)sortDescriptors predicate:(NSPredicate*)predicate;
@end
