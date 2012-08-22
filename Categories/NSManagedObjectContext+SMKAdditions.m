//
//  NSManagedObjectContext+SMKAdditions.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-22.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "NSManagedObjectContext+SMKAdditions.h"

@implementation NSManagedObjectContext (SMKAdditions)
- (BOOL)SMK_saveChanges
{
    NSError *error = nil;
    if (![self save:&error]) {
        NSLog(@"NSManagedObjectContext save error: %@ %@", error, [error userInfo]);
        return NO;
    }
    return YES;
}
@end
