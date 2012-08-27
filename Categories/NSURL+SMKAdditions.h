//
//  NSURL+SMKAdditions.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-22.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TargetConditionals.h"

@interface NSURL (SMKAdditions)
#if !TARGET_OS_IPHONE
/**
 @return The URL to the main bundle's Application Support folder
 */
+ (NSURL *)SMK_applicationSupportFolder;
#endif
@end
