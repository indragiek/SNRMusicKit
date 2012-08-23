//
//  SMKManagedObjectContext.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-23.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "SMKContentSource.h"

@interface SMKManagedObjectContext : NSManagedObjectContext
@property (nonatomic, strong) id<SMKContentSource> SMK_contentSource;
@end
