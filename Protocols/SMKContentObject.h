//
//  SMKContentObject.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-21.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SMKContentSource;
@protocol SMKContentObject <NSObject>
@required
/**
 @return The name of the object.
 */
- (NSString *)name;

/**
 @return A unique identifier string for the object;
 */
- (NSString *)uniqueIdentifier;

/**
 @return The SMKContentSource object that this object belongs to
 */
- (id<SMKContentSource>)contentSource;

/**
 @return A set of keys that are supported for sorting
 */
+ (NSSet *)supportedSortKeys;
@end
