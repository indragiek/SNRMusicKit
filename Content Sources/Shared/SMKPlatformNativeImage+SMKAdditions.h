//
//  SMKPlatformNativeImage+SMKAdditions.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-26.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SMKPlatformImports.h"

// Based on ImageCrop source code by Matt Gemmell
// <http://mattgemmell.com/2006/03/16/imagecrop-source-code/>

typedef enum {
    SMKImageResizeCrop,
    SMKImageResizeCropStart,
    SMKImageResizeCropEnd,
    SMKImageResizeScale
} SMKImageResizingMethod;

@interface SMKPlatformNativeImage (SMKAdditions)
- (SMKPlatformNativeImage *)imageScaledToFitSize:(CGSize)size;
- (SMKPlatformNativeImage *)imageCroppedToFitSize:(CGSize)size;
- (SMKPlatformNativeImage *)imageToFitSize:(CGSize)size method:(SMKImageResizingMethod)resizeMethod;
@end
