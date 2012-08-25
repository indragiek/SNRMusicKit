//
//  NSObject+SMKAdditions.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-24.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "NSObject+SMKAdditions.h"
#import "NSObject+AssociatedObjects.h"
#import "SMKSemaphoreWrapper.h"

static void* const SMKObjectSemaphoreWrapperKey = @"SMK_semaphoreWrapper";

@implementation NSObject (SMKAdditions)
- (void)SMK_semaphoreSignal
{
    [[self SMK_retrieveOrCreateSemaphore] signal];
}
- (void)SMK_semaphoreWait:(dispatch_time_t)time
{
    [[self SMK_retrieveOrCreateSemaphore] wait:time];
    [self SMK_semaphoreDestruct];
}

- (SMKSemaphoreWrapper *)SMK_retrieveOrCreateSemaphore
{
    SMKSemaphoreWrapper *wrapper = [self associatedValueForKey:SMKObjectSemaphoreWrapperKey];
    if (!wrapper) {
        wrapper = [SMKSemaphoreWrapper new];
        [self associateValue:wrapper withKey:SMKObjectSemaphoreWrapperKey];
    }
    return wrapper;
}

- (BOOL)SMK_semaphoreExists
{
    return [self associatedValueForKey:SMKObjectSemaphoreWrapperKey] != nil;
}

- (void)SMK_semaphoreDestruct
{
    [self associateValue:nil withKey:SMKObjectSemaphoreWrapperKey];
}
@end
