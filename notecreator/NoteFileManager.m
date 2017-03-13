#define kBundlePath @"/Library/MobileSubstrate/DynamicLibraries/com.isklikas.NoteCreator.bundle"
#import "NoteFileManager.h"

@interface NoteFileManager()
@end

@implementation NoteFileManager

- (NSString *) objectOfNameAtBundle:(NSString *)name {
	  NSBundle *bundle = [[NSBundle alloc] initWithPath:kBundlePath];
		NSArray *fileConstruct = [name componentsSeparatedByString:@"."];
		NSString *filename = @"";
		NSString *type;
		for (int i=0; i<fileConstruct.count; i++) {
			  if (i == fileConstruct.count-1) {
					  type = fileConstruct[i];
				}
				else {
					  filename = [filename stringByAppendingString:fileConstruct[i]];
						//for example if named name.bg.png
						if (i < fileConstruct.count-2) {
							filename = [filename stringByAppendingString:@"."];
						}
						
				}
		}
    NSString *path = [bundle pathForResource:filename ofType:type];
		return path;
}

@end