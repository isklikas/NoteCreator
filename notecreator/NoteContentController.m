#import "NoteScreenContainer.h" //It has both class definitions and is needed for the quit method


@interface NoteContentController()
@end

@implementation NoteContentController

//Before the Table View Delegate Methods
- (void)loadView {
    [super loadView];
    NotePrefManager *prefManager = [[NotePrefManager alloc] init];
    NoteFileManager *fileManager = [[NoteFileManager alloc] init];
    if ([prefManager titleEnabled]) {
      self.titleCell = [[UITableViewCell alloc] init];
      self.titleField = [[UITextField alloc] initWithFrame:self.titleCell.frame];
      [self.titleField setDelegate:self];
      [self.titleField setPlaceholder:[fileManager localisedString:@"Title"]];
      [self.titleCell addSubview:_titleField];
      [self.titleCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    self.noteCell = [[UITableViewCell alloc] init];
    self.noteView = [[UITextView alloc] initWithFrame:self.noteCell.frame];
    [self.noteCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self.noteView setDelegate:self];
    [self.noteCell addSubview:_noteView];
    self.accountCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"AccountCell"];
    self.accountCell.textLabel.text = @"Accounts";
    self.accountCell.detailTextLabel.text = @"iCloud";
    self.accountCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

//Other view set-ups.
 -(void)viewWillAppear:(BOOL)animated {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    NoteFileManager *fileManager = [[NoteFileManager alloc] init];
    NSString *noteStr = [fileManager localisedString:@"Note"];
    self.navigationItem.title = noteStr;
    NSString *cancel = [fileManager localisedString:@"Cancel"]; //NSLocalizedStringFromTableInBundle(@"Cancel", nil, ourBundle, nil);
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:cancel style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
    NSString *done = [fileManager localisedString:@"Done"];//NSLocalizedStringFromTableInBundle(@"Done", nil, ourBundle, nil);
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:done style:UIBarButtonItemStyleDone target:self action:@selector(done:)];
    self.navigationItem.rightBarButtonItem = doneButton;
    self.navigationItem.leftBarButtonItem = cancelButton;
    UITableView *tblView = [[UITableView alloc] initWithFrame:self.view.frame];
    tblView.delegate = self;
    tblView.dataSource = self;
    tblView.scrollEnabled = FALSE;
		[self.view addSubview:tblView];
     _tblView = tblView;
     [self setupConstraints];
}

- (void)setupConstraints {
    NotePrefManager *prefManager = [[NotePrefManager alloc] init];
    if ([prefManager titleEnabled]) {
        [self.titleField setTranslatesAutoresizingMaskIntoConstraints:NO];
        NSLayoutConstraint *width =[NSLayoutConstraint constraintWithItem:self.titleField attribute:NSLayoutAttributeWidth relatedBy:0 toItem:self.titleCell attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
        NSLayoutConstraint *height =[NSLayoutConstraint constraintWithItem:self.titleField attribute:NSLayoutAttributeHeight relatedBy:0 toItem:self.titleCell attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.titleField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleCell attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.f];
        NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.titleField attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.titleCell attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.f];
        [self.titleCell addConstraint:width];
        [self.titleCell addConstraint:height];
        [self.titleCell addConstraint:top];
        [self.titleCell addConstraint:leading];
    }
    [self.noteView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *width =[NSLayoutConstraint constraintWithItem:self.noteView attribute:NSLayoutAttributeWidth relatedBy:0 toItem:self.noteCell attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    NSLayoutConstraint *height =[NSLayoutConstraint constraintWithItem:self.noteView attribute:NSLayoutAttributeHeight relatedBy:0 toItem:self.noteCell attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.noteView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.noteCell attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.f];
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.noteView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.noteCell attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.f];
    [self.noteCell addConstraint:width];
    [self.noteCell addConstraint:height];
    [self.noteCell addConstraint:top];
    [self.noteCell addConstraint:leading];
}

- (void) done:(id) sender {
    [(NoteScreenContainer *)[self parentViewController] quitNoteCreator];
}

- (void) cancel:(id) sender {
    [(NoteScreenContainer *)[self parentViewController] quitNoteCreator];
}

//Table View Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  NotePrefManager *prefManager = [[NotePrefManager alloc] init];
  if ([prefManager titleEnabled]) {
    return 3;
  }
  return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NotePrefManager *prefManager = [[NotePrefManager alloc] init];
    switch (indexPath.row) {
        case 0:
          if ([prefManager titleEnabled]) {
            return self.titleCell;
          }
          return self.noteCell;
          break; //These break statements aren't necessary in any way, as return is always the last statement, however if anyone uses this to see switch syntax, the 'break' statement is usually necessary;
        case 1:
          if ([prefManager titleEnabled]) {
            return self.noteCell;
          }
          return self.accountCell;
          break;
        case 2: //If there is a 2, then there must be 3 cells, so no need for a check here
          return self.accountCell;
          break;
        default:
          [NSException raise:@"UnknownIndexException" format:@"Index %ld corresponds to no cell", (long)indexPath.row];
          return nil;
          break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger rows = [self tableView:_tblView numberOfRowsInSection:0];
    CGFloat tblHeight = self.tblView.frame.size.height-44;
    switch (indexPath.row) {
        case 0:
            if (rows == 3) {
                return 44;
            }
            return tblHeight-44;
            break;
        case 1:
            if (rows == 3) {
                return tblHeight-88;
            }
            return 44;
            break;
        case 2:
            return 44;
            break;
        default:
            [NSException raise:@"UnknownIndexException" format:@"Index %ld corresponds to no cell", (long)indexPath.row];
            return 0;
            break;
    }
}


@end
