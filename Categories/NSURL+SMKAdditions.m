//
//  NSURL+SMKAdditions.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-22.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "NSURL+SMKAdditions.h"
#import "NSBundle+SMKAdditions.h"

@implementation NSURL (SMKAdditions)
#if !TARGET_OS_IPHONE
+ (NSURL *)SMK_applicationSupportFolder
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *appSupportURL = [[fileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject];
    return [appSupportURL URLByAppendingPathComponent:[[NSBundle mainBundle] SMK_bundleName]];
}
#endif
@end
