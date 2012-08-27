//
//  NSString+SMKAdditions.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-22.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SMKAdditions)
/**
 @return A normalized string by stripping out case and diacritic characters
 */
- (NSString *)SMK_normalizedString;

/**
 @return The string's MD5 hash
 */
- (NSString *)SMK_MD5Hash;
@end
