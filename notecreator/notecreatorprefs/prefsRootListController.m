#define kBundlePath @"/Library/PreferenceBundles/NoteCreatorPrefs.bundle"
#include "prefsRootListController.h"

@implementation prefsRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		NSMutableArray *specifs = [NSMutableArray new];
		NSArray *tmpSpecifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
		for (PSSpecifier *specifier in tmpSpecifiers) {
		    	NSBundle *bundle = [[NSBundle alloc] initWithPath:kBundlePath];
		    	NSString *bPath = [bundle pathForResource:@"Translations" ofType:@"bundle"];
			    NSBundle *ourBundle = [[NSBundle alloc] initWithPath:bPath];
					NSString *title = specifier.name;
			    NSString *localTitle = NSLocalizedStringFromTableInBundle(title, nil, ourBundle, nil);
					specifier.name = localTitle;
					NSDictionary *properties = specifier.properties;
					NSString *ftText = [properties objectForKey:@"footerText"];
					if (ftText != nil) {
				     NSString *footerText = NSLocalizedStringFromTableInBundle(ftText, nil, ourBundle, nil);
						 [specifier setProperty:footerText forKey:@"footerText"];
					}
					NSLog(@"The details required are: %@, %@", specifier.name, specifier.properties);
					[specifs addObject:specifier];
		}
		_specifiers = [specifs copy];
	}
	return _specifiers;
}

@end
