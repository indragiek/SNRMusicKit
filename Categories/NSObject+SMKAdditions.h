//
//  NSObject+SMKAdditions.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-24.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (SMKAdditions)
- (void)SMK_semaphoreSignal;
- (void)SMK_semaphoreWait:(dispatch_time_t)time;
- (BOOL)SMK_semaphoreExists;
@end
