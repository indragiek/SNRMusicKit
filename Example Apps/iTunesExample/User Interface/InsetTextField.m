//
//  InsetTextField.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-23.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "InsetTextField.h"

@implementation InsetTextField

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        [[self cell] setBackgroundStyle:NSBackgroundStyleRaised];
    }
    return self;
}

@end
