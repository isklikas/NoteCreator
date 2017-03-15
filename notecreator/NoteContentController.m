#import "NoteContentController.h"

@interface NoteContentController()
@end

@implementation NoteContentController
 
 //Before the Table View Delegate Methods
 - (void)loadView {
     [super loadView];
    self.titleCell = [[UITableViewCell alloc] init];
    self.titleField = [[UITextField alloc] initWithFrame:self.titleCell.contentView.bounds];
    [self.titleField setBackgroundColor:[UIColor greenColor]];
    self.noteCell = [[UITableViewCell alloc] init];
    self.noteView = [[UITextView alloc] initWithFrame:self.noteCell.contentView.bounds];
    [self.noteView setBackgroundColor:[UIColor orangeColor]];
}
 
 //Other view set-ups.
 -(void)viewWillLayoutSubviews {
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
    UITableView *tblView = [[UITableView alloc] initWithFrame:self.view.frame];
    tblView.delegate = self;
    tblView.dataSource = self;
    [self.view addSubview:tblView];
 	  //navigationController = [[UINavigationController alloc] initWithRootViewController:notes];
 }
 
 //Table View Data Source Methods
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	  return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            return self.titleCell;
            break; //These break statements aren't necessary in any way, as return is always the last statement, however if anyone uses this to see switch syntax, the 'break' statement is usually necessary;
        case 1:
            return self.noteCell;
            break;
        case 2:
            self.accountCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"AccountCell"];
            self.accountCell.textLabel.text = @"Accounts";
            self.accountCell.detailTextLabel.text = @"iCloud";
            self.accountCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return self.accountCell;
            break;
        default:
            [NSException raise:@"UnknownIndexException" format:@"Index %ld corresponds to no cell", (long)indexPath.row];
            return nil;
            break;
		}
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

 
 @end
