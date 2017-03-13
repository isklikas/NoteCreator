#import <Foundation/Foundation.h>

@interface NoteFileManager: NSObject{}
- (NSString *) objectOfNameAtBundle:(NSString *)name;
- (NSString *) localisedString:(NSString *)string;
@end