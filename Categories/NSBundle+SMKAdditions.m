//
//  NSBundle+SMKAdditions.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-22.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "NSBundle+SMKAdditions.h"
#import "SNRMusicKitMac.h"

@implementation NSBundle (SMKAdditions)
#if !TARGET_OS_IPHONE
+ (NSBundle *)SMK_frameworkBundle
{
    return [NSBundle bundleForClass:[SNRMusicKitMac class]];
}
#endif

- (NSString *)SMK_bundleName
{
    return [[self infoDictionary] valueForKey:@"CFBundleName"];
}
@end
