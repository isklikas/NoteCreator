#import "NoteContentController.h"

@interface NoteContentController()
@end

@implementation NoteContentController
 
 -(void)viewDidLoad {
 	  [self.view setBackgroundColor:[UIColor whiteColor]];
		NoteFileManager *fileManager = [[NoteFileManager alloc] init];
		NSString *noteStr = [fileManager localisedString:@"Note"];
		self.navigationItem.title = noteStr;
    NSString *cancel = [fileManager localisedString:@"Cancel"]; //NSLocalizedStringFromTableInBundle(@"Cancel", nil, ourBundle, nil);
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:cancel style:UIBarButtonItemStyleBordered target:self action:@selector(cancel:)];
    NSString *done = [fileManager localisedString:@"Done"];//NSLocalizedStringFromTableInBundle(@"Done", nil, ourBundle, nil);
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:done style:UIBarButtonItemStyleBordered target:self action:@selector(done:)];
    self.navigationItem.rightBarButtonItem = doneButton;
    self.navigationItem.leftBarButtonItem = cancelButton;
 	  //navigationController = [[UINavigationController alloc] initWithRootViewController:notes];
 }
 @end