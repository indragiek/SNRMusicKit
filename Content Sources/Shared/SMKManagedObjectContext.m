//
//  SMKManagedObjectContext.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-23.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SMKManagedObjectContext.h"

@implementation SMKManagedObjectContext
@synthesize defaultFetchBatchSize = _defaultFetchBatchSize;

- (id)initWithConcurrencyType:(NSManagedObjectContextConcurrencyType)ct
{
    if ((self = [super initWithConcurrencyType:ct])) {
        self.defaultFetchBatchSize = 20;
    }
    return self;
}
@end
