//
//  SMKiTunesImportOperation.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-22.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SMKiTunesContentSource;
@interface SMKiTunesImportOperation : NSOperation
@property (nonatomic, weak) SMKiTunesContentSource *contentSource;
@end
