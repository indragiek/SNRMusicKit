//
//  SMKMacros.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-22.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

static inline BOOL SMKObjectIsValid(id object) {
	return (object == nil)
    || (object == [NSNull null])
    || ([object respondsToSelector:@selector(length)]
        && [(NSData *)object length] == 0)
    || ([object respondsToSelector:@selector(count)]
        && [(NSArray *)object count] == 0);
}