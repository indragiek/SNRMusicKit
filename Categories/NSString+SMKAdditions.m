//
//  NSString+SMKAdditions.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-22.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "NSString+SMKAdditions.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (SMKAdditions)
- (NSString *)SMK_normalizedString
{
    NSMutableString *result = [NSMutableString stringWithString:self];
    CFStringNormalize((__bridge CFMutableStringRef)result, kCFStringNormalizationFormD);
    CFStringFold((__bridge CFMutableStringRef)result, kCFCompareCaseInsensitive | kCFCompareDiacriticInsensitive | kCFCompareWidthInsensitive, NULL);
    return result;
}

- (NSString *)SMK_MD5Hash
{
    const char *ptr = [self UTF8String];
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(ptr, (int)strlen(ptr), md5Buffer);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",md5Buffer[i]];
    return output;
}
@end
