//
//  SMKMPMediaPredicate.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-27.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 This is a wrapper class that encapsulates a set of MPMediaPropertyPredicates
 to allow them to be passed as a single predicate object in order to conform
 to the SNRMusicKit protocols.
 */
@interface SMKMPMediaPredicate : NSObject
@property (nonatomic, strong, readonly) NSSet *predicates;
/**
 Creates a new SMKMPMediaPredicate object with the specified subpredicates.
 @param predicates Set of MPMediaPropertyPredicate objects
 */
- (id)initWithMediaPropertyPredicates:(NSSet *)predicates;
+ (instancetype)predicateWithMediaPropertyPredicates:(NSSet *)predicates;
@end
