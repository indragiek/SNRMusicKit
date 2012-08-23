#import "_SMKiTunesAlbum.h"
#import "SMKAlbum.h"

@interface SMKiTunesAlbum : _SMKiTunesAlbum <SMKAlbum> {}
/**
 iTunes only contains the year information, not the other components of the release date.
 It's always preferable to call -releaseYear instead since that's the only real information we have,
 but in the scenario that this method is called, it is implemented so it returns the first day of the first month of that year, time 12:00:00 
 */
- (NSDate *)releaseDate;

- (NSNumber *)duration;
@end
