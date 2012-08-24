//
//  SMK8TracksObject.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-23.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMKContentSource.h"

@interface SMK8TracksObject : NSObject
@property (nonatomic, weak) id<SMKContentSource> contentSource;
@end
