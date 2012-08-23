//
//  SMKiTunesSyncOperation.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-22.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SMKiTunesContentSource;
@interface SMKiTunesSyncOperation : NSOperation
@property (nonatomic, weak) SMKiTunesContentSource *contentSource;

@property (nonatomic, copy) void (^completionBlock)(SMKiTunesSyncOperation *operation, NSUInteger importedCount);
@property (nonatomic, copy) void (^progressBlock)(SMKiTunesSyncOperation *operation, NSUInteger trackNumber, NSUInteger totalTracks, NSError *error);
@end