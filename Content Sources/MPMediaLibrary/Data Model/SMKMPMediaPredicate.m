//
//  SMKMPMediaPredicate.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-27.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SMKMPMediaPredicate.h"

@implementation SMKMPMediaPredicate

- (id)initWithMediaPropertyPredicates:(NSSet *)predicates
{
    if ((self = [super init])) {
        _predicates = predicates;
    }
    return self;
}

+ (instancetype)predicateWithMediaPropertyPredicates:(NSSet *)predicates
{
    return [[self alloc] initWithMediaPropertyPredicates:predicates];
}
@end
