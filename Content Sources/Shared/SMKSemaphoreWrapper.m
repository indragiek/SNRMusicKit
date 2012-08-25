//
//  SMKSemaphoreWrapper.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-24.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SMKSemaphoreWrapper.h"

@implementation SMKSemaphoreWrapper {
    dispatch_semaphore_t _semaphore;
}

- (id)init
{
    if ((self = [super init])) {
        _semaphore = dispatch_semaphore_create(0);
    }
    return self;
}

- (void)dealloc
{
    dispatch_release(_semaphore);
}

- (void)wait:(dispatch_time_t)time
{
    dispatch_semaphore_wait(_semaphore, time);
}

- (void)signal
{
    dispatch_semaphore_signal(_semaphore);
}
@end
