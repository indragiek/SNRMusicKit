//
//  SMKWebObject.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-21.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SMKWebObject <NSObject>
@required
/**
 @return The URL to the web page for this content object.
 */
- (NSURL *)webURL;
@end
