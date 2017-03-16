#import "NotePrefManager.h"

@interface NotePrefManager()
@end

@implementation NotePrefManager

- (BOOL)titleEnabled {
		BOOL titleEnabled = [[[self preferencesDictionary] objectForKey:@"SwitchCell6"] boolValue];
		return titleEnabled;
}

- (BOOL)autoKeyboard {
	  BOOL autoKeyboard = [[[self preferencesDictionary] objectForKey:@"SwitchCell5"] boolValue];
		return autoKeyboard;
}

- (BOOL)saveOnCancel {
	  BOOL saveOnCancel = [[[self preferencesDictionary] objectForKey:@"SwitchCell2"] boolValue];
		return saveOnCancel;
}

- (NSDictionary *)preferencesDictionary {
	  NSString *path = [@"/var/mobile/Library/Preferences" stringByAppendingPathComponent:@"com.isklikas.NoteCreatorPrefs.plist"];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:path];
		return dictionary;
}

@end
