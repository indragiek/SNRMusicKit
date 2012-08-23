//
//  SMKiTunesContentSource.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-21.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMKContentSource.h"

@interface SMKiTunesContentSource : NSObject <SMKContentSource>
#pragma mark - Content Source Specific API
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;

/** Starts a sync with iTunes. This method is called automatically in SMKiTunesContentSource's -init. */
- (void)sync;
/** 
 Deletes the persistent store used to cache the iTunes Library info.
 @discussion You must manually call -sync again before accessing anything
 */
- (void)deleteStore;
@end
