//
//  SMKMPMediaPlaylist.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-27.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SMKMPMediaPlaylist.h"
#import "SMKMPMediaContentSource.h"
#import "SMKMPMediaTrack.h"

@interface SMKMPMediaTrack (SMKInternal)
- (id)initWithRepresentedObject:(MPMediaItem*)object contentSource:(id<SMKContentSource>)contentSource;
@end

@implementation SMKMPMediaPlaylist

- (id)initWithRepresentedObject:(MPMediaItemCollection*)object contentSource:(id<SMKContentSource>)contentSource
{
    if ((self = [super init])) {
        _representedObject = object;
        _contentSource = contentSource;
    }
    return self;
}

#pragma mark - SMKContentObject

- (NSString *)uniqueIdentifier
{
    return [[self.representedObject valueForProperty:MPMediaPlaylistPropertyPersistentID] stringValue];
}

- (NSString *)name
{
    return [self.representedObject valueForProperty:MPMediaPlaylistPropertyName];
}

+ (NSSet *)supportedSortKeys
{
    return [NSSet setWithObjects:@"name", nil];
}

#pragma mark - SMKPlaylist

- (void)fetchTracksWithCompletionHandler:(void(^)(NSArray *tracks, NSError *error))handler
{
    __weak SMKMPMediaPlaylist *weakSelf = self;
    dispatch_async([(SMKMPMediaContentSource*)self.contentSource queryQueue], ^{
        SMKMPMediaPlaylist *strongSelf = weakSelf;
        NSArray *items = [strongSelf.representedObject items];
        NSMutableArray *tracks = [NSMutableArray arrayWithCapacity:[items count]];
        [items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            SMKMPMediaTrack *track = [[SMKMPMediaTrack alloc] initWithRepresentedObject:obj contentSource:strongSelf.contentSource];
            [tracks addObject:track];
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (handler) handler(tracks, nil);
        });
    });
}

- (BOOL)isEditable
{
    return NO;
}
@end
