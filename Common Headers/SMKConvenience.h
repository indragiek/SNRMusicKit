//
//  SMKMacros.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-22.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SMKPlatformImports.h"

static inline BOOL SMKObjectIsValid(id object)
{
	return (object != nil)
    && (object != [NSNull null])
    && (![object respondsToSelector:@selector(length)]
        || [(NSData *)object length] != 0)
    && (![object respondsToSelector:@selector(count)]
        || [(NSArray *)object count] != 0);
}
static inline void SMKGenericErrorLog(NSString *errorText, NSError *error)
{
    if (![errorText length])
        errorText = @"Error";
    NSLog(@"%@: %@, %@", errorText, error, [error userInfo]);
}

static inline NSData* SMKImageJPEGRepresentation(SMKPlatformNativeImage *image, CGFloat compressionQuality)
{
#if TARGET_OS_IPHONE
    return UIImageJPEGRepresentation(image, compressionQuality);
#else
    NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:compressionQuality] forKey:NSImageCompressionFactor];
    return [NSBitmapImageRep representationOfImageRepsInArray:[image representations] usingType: NSJPEGFileType properties:options];
#endif
}