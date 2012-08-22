//
//  SMKiTunesImportOperation.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-22.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SMKiTunesImportOperation.h"
#import "SMKiTunesConstants.h"

@interface SMKiTunesImportOperation ()
@end

@implementation SMKiTunesImportOperation {
    NSDictionary *_iTunesDictionary;
}
@synthesize contentSource = _contentSource;

- (id)init
{
    NSURL *libraryURL = [[self class] iTunesLibraryURL];
    if (!libraryURL) { return nil; }
    NSData *data = [NSData dataWithContentsOfURL:libraryURL];
    NSError *error = nil;
    _iTunesDictionary = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:&error];
    if (error) {
        NSLog(@"Error reading iTunes Music Library.xml: %@, %@", error, [error userInfo]);
    }
}

- (void)main
{
    
}

#pragma mark - Private

- (NSURL *)iTunesLibraryURL
{
    NSArray *libraryDatabases = [[[NSUserDefaults standardUserDefaults] persistentDomainForName:@"com.apple.iApps"] objectForKey:@"iTunesRecentDatabases"];
    return (([libraryDatabases count])) ? [NSURL URLWithString:[libraryDatabases objectAtIndex:0]] : nil;
}
@end
