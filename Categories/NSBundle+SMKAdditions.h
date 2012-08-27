//
//  NSBundle+SMKAdditions.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-22.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TargetConditionals.h"

@interface NSBundle (SMKAdditions)
#if !TARGET_OS_IPHONE
/**
 Returns the bundle for the framework itself
 */
+ (NSBundle *)SMK_frameworkBundle;
#endif
/**
 Returns the name of the bundle (CFBundleName)
 */
- (NSString *)SMK_bundleName;
@end
