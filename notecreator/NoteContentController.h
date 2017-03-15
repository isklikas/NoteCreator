#import <UIKit/UIKit.h>
#import "NoteFileManager.h"

@interface NoteContentController: UIViewController <UITableViewDataSource, UITableViewDelegate>{}

//We will be creating a static Table View, so we will have a property for every cell and its view.
@property UITableViewCell *titleCell;
@property UITableViewCell *noteCell;
@property UITableViewCell *accountCell;

//And now, for their views
@property UITextField *titleField;
@property UITextView *noteView;

@end