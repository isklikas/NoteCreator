//
//  NoteController.m
//  CallShare
//
//  Created by Yannis on 12/9/13.
//
//

#define kBundlePath @"/Library/MobileSubstrate/DynamicLibraries/com.isklikas.NoteCreator.bundle"
#import "NoteController.h"
UINavigationItem *navigItem;
NSString *nAccount;
NSInteger storeNum;
UITableView *accountName;
UIWindow *popUp;
NSString *noteOut;
NSString *titleOut;
UIView *noteView;
UIWindow *prevWin;

@interface NoteController ()

@end

@interface NoteContext : NSObject {}
-(void)enableChangeLogging:(BOOL)arg1;
@end

@interface NoteBodyObject : NSObject{}
@property NSString *content;
@property id owner;
@end

@interface NoteObject : NSObject{}
@property NSString *title;
@property id store;
@property NSString *summary;
@property NSNumber *integerId;
@property NSDate *creationDate;
@property NSDate *modificationDate;
@property NoteBodyObject *body;
-(void)setIsPlainText:(BOOL)arg1;
@end

@implementation NoteController


-(void)viewWillAppear:(BOOL)animated {
    if (note!=nil) {
        noteOut = note.text;
    }
    if (titleField!=nil) {
        titleOut = titleField.text;
    }
        NSArray *viewsToRemove = [self.view subviews];
        for (UIView *v in viewsToRemove) {
            [v setHidden:TRUE];
        }
        [self repeatedCreations];

}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}
- (void)registerForKeyboardNotifications {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWasShown:)
                                                     name:UIKeyboardDidShowNotification object:nil];

}

    // Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification {
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {

    }
    else {
        [UIView beginAnimations:@"noteView" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView setAnimationDuration:0.27f];
        UIView *arectView = [[UIView alloc] initWithFrame:aRect];
        noteView.center = arectView.center;
        [UIView commitAnimations];

    }
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            [note resignFirstResponder];
            [titleField resignFirstResponder];
        noteOut = note.text;
        titleOut = titleField.text;
        NSArray *viewsToRemove = [self.view subviews];
        for (UIView *v in viewsToRemove) {
            [v removeFromSuperview];
        }
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        noteOut = note.text;
        titleOut = titleField.text;
        [self repeatedCreations];
    }
}

//NEW IMAGES
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return YES;
    }
    else {
        return NO;
    }
}


-(void)viewDidAppear:(BOOL)animated {
    NSString *path = [@"/var/mobile/Library/Preferences" stringByAppendingPathComponent:@"com.isklikas.NoteCreatorPrefs.plist"];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:path];
    BOOL keyAuto = [[dictionary objectForKey:@"SwitchCell5"] boolValue];
    if (keyAuto) {
        [note becomeFirstResponder];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSBundle *bundle = [[NSBundle alloc] initWithPath:kBundlePath];
    NSString *bPath = [bundle pathForResource:@"Translations" ofType:@"bundle"];
    NSBundle *ourBundle = [[NSBundle alloc] initWithPath:bPath];
    NSString *indexShown = NSLocalizedStringFromTableInBundle(@"Default", nil, ourBundle, nil);
    nAccount = indexShown;
    titleOut = NSLocalizedStringFromTableInBundle(@"Title", nil, ourBundle, nil);
    NSString *noteStr = NSLocalizedStringFromTableInBundle(@"Note", nil, ourBundle, nil);
    noteOut = @"  ";
    noteOut = [noteOut stringByAppendingString:noteStr];
    NSString *path2 = [@"/var/mobile/Library/Preferences" stringByAppendingPathComponent:@"com.isklikas.NoteCreatorPrefs.plist"];
    NSDictionary *dictionary2 = [[NSDictionary alloc] initWithContentsOfFile:path2];
    BOOL keyAuto2 = [[dictionary2 objectForKey:@"SwitchCell2"] boolValue];
    NSString *path = [bundle pathForResource:@"noteText" ofType:@"plist"];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:path];
    if ([[dictionary objectForKey:@"Header"] isEqualToString:@"Title"] || [dictionary objectForKey:@"Header"] == nil || [[dictionary objectForKey:@"Header"] isEqualToString:@""]) {
        titleOut = NSLocalizedStringFromTableInBundle(@"Title", nil, ourBundle, nil);
    }
    else {
        if (keyAuto2) {
            titleOut=[dictionary objectForKey:@"Header"];
        }
        else {
            titleOut = NSLocalizedStringFromTableInBundle(@"Title", nil, ourBundle, nil);
        }
    }
    NSString *keyAuto = [dictionary objectForKey:@"Title"];
    if ([keyAuto isEqualToString:[@"  " stringByAppendingString:NSLocalizedStringFromTableInBundle(@"Note", nil, ourBundle, nil)]] || [keyAuto isEqualToString:@"  Note"] || keyAuto==nil || [keyAuto isEqualToString:@""]) {
        NSString *noteStr = NSLocalizedStringFromTableInBundle(@"Note", nil, ourBundle, nil);
        noteOut = @"  ";
        noteOut = [noteOut stringByAppendingString:noteStr];
    }
    else {
        if (keyAuto2) {
            noteOut=keyAuto;
        }
        else {
            NSString *noteStr = NSLocalizedStringFromTableInBundle(@"Note", nil, ourBundle, nil);
            noteOut = @"  ";
            noteOut = [noteOut stringByAppendingString:noteStr];
        }
    }
    [self repeatedCreations];
}

-(void) repeatedCreations {
    UIImageView *transparentBG = [[UIImageView alloc] initWithFrame:self.view.bounds];
    NSBundle *bundle = [[NSBundle alloc] initWithPath:kBundlePath];
    NSString *path = [bundle pathForResource:@"bg" ofType:@"png"];
    UIImage *bg = [UIImage imageWithContentsOfFile:path];
    [transparentBG setImage:bg];
    [self.view addSubview:transparentBG];
    self.title = @"Note";
    /*
     if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
     [self registerForKeyboardNotifications];
     }
     */
    [self.navigationController setNavigationBarHidden:TRUE animated:FALSE];
    noteView = [self createNote];
    noteView.center = self.view.center;
    noteView.alpha = 0.0f;;
    [self.view addSubview:noteView];
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         noteView.alpha = 1.0f;
                     }
                     completion:^(BOOL finished) {
                     }];
}


-(UIView *)createNote {
    NSString *path = [@"/var/mobile/Library/Preferences" stringByAppendingPathComponent:@"com.isklikas.NoteCreatorPrefs.plist"];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:path];
    BOOL titleField2 = [[dictionary objectForKey:@"SwitchCell6"] boolValue];
    NSBundle *bundle = [[NSBundle alloc] initWithPath:kBundlePath];
    NSString *bPath = [bundle pathForResource:@"Translations" ofType:@"bundle"];
    NSBundle *ourBundle = [[NSBundle alloc] initWithPath:bPath];
    NSString *noteStr = NSLocalizedStringFromTableInBundle(@"Note", nil, ourBundle, nil);
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    CGFloat shared = screenHeight - 225;
    CGFloat lineHeight = 0.5;
    shared = shared/4;
    CGFloat heightv = 225;
    CGFloat widthv = 290;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        widthv = 538;
        heightv = 250;
        lineHeight = 1;
    }
    UIView *noteView = [[UIView alloc] initWithFrame:CGRectMake(15, 20.60, widthv, heightv)];
    [noteView setBackgroundColor:[UIColor whiteColor]];
    UINavigationBar *noteNavigation = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, widthv, 44)];
    noteNavigation.topItem.title = noteStr;
    NSString *cancel = NSLocalizedStringFromTableInBundle(@"Cancel", nil, ourBundle, nil);
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:cancel style:UIBarButtonItemStyleBordered target:self action:@selector(cancel:)];
    NSString *done = NSLocalizedStringFromTableInBundle(@"Done", nil, ourBundle, nil);
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:done style:UIBarButtonItemStyleBordered target:self action:@selector(done:)];
    noteNavigation.topItem.rightBarButtonItem = doneButton;
    noteNavigation.topItem.leftBarButtonItem = cancelButton;
    navigItem = [[UINavigationItem alloc] initWithTitle:noteStr];
    navigItem.rightBarButtonItem = doneButton;
    navigItem.leftBarButtonItem = cancelButton;
    noteNavigation.items = [NSArray arrayWithObjects: navigItem,nil];
    [noteView addSubview:noteNavigation];
    CGFloat heightNote = heightv - 87 - lineHeight;
    note = [[UITextView alloc] init];
    if (titleField2) {
        note.frame = CGRectMake(0, 2*lineHeight + 79.4375, widthv, heightNote);
        titleField = [[UITextField alloc] initWithFrame:CGRectMake(15, 44 + lineHeight + 10.8125, widthv-15, 23.625)];
        titleField.placeholder = NSLocalizedStringFromTableInBundle(@"Title", nil, ourBundle, nil);
        LineCreator *upperLine = [[LineCreator alloc] initWithFrame:CGRectMake(14, 79.4375+lineHeight, widthv-14, lineHeight)];
        upperLine.backgroundColor = [UIColor colorWithRed:192.0f/255.0f green:192.0f/255.0f blue:192.0f/255.0f alpha:1.0f];
        titleField.delegate = self;
        titleField.returnKeyType = UIReturnKeyDone;
        if (titleOut != nil && [titleOut isEqualToString:NSLocalizedStringFromTableInBundle(@"Title", nil, ourBundle, nil)]==FALSE) {
            titleField.text = titleOut;
        }
        [noteView addSubview:upperLine];
        [noteView addSubview:titleField];
    }
    else {
        note.frame = CGRectMake(0, 44 + lineHeight, widthv, heightNote);
    }
    note.delegate = self;
    note.returnKeyType = UIReturnKeyDefault;
    [note setFont:[UIFont systemFontOfSize:17]];
    if (noteOut!=nil) {
        [note setText:noteOut];
    }

    if ([noteOut isEqualToString:[@"  " stringByAppendingString:noteStr]]) {
        note.textColor = [UIColor colorWithRed:192.0f/255.0f green:192.0f/255.0f blue:192.0f/255.0f alpha:1.0f];
    }
    [noteView addSubview:note];
    accountName = [[UITableView alloc] initWithFrame:CGRectMake(0, 44+heightNote, widthv, 43+lineHeight) style:UITableViewStylePlain];
    accountName.delegate = self;
    accountName.dataSource = self;
    [noteView addSubview:accountName];
    //VOILA, change to text View, add new classes and methods, Update .h and name!!!
    accountName.scrollEnabled = NO;
    LineCreator *line = [[LineCreator alloc] initWithFrame:CGRectMake(0, 44-lineHeight+heightNote, widthv, lineHeight)];
    line.backgroundColor = [UIColor colorWithRed:192.0f/255.0f green:192.0f/255.0f blue:192.0f/255.0f alpha:1.0f];
    [noteView addSubview:line];
    LineCreator *topLine = [[LineCreator alloc] initWithFrame:CGRectMake(0, 44, widthv, lineHeight)];
    topLine.backgroundColor = [UIColor colorWithRed:192.0f/255.0f green:192.0f/255.0f blue:192.0f/255.0f alpha:1.0f];
    [noteView addSubview:topLine];
    noteView.layer.cornerRadius = 5;
    noteView.layer.masksToBounds = YES;
    return noteView;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField*)textfield {
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
    CGRect aRect = self.view.frame;
    CGFloat removal = 216;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        removal = 352;
    }
    aRect.size.height -= removal;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad && orientation == UIInterfaceOrientationPortrait) {

    }
    else {
        [UIView beginAnimations:@"noteView" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView setAnimationDuration:0.27f];
        UIView *arectView = [[UIView alloc] initWithFrame:aRect];
        noteView.center = arectView.center;
        [UIView commitAnimations];

    }
    return YES;
    }
    else {
        CGFloat lineHeight = 0.5;
        CGFloat heightv = 225;
        CGFloat widthv = 290;
        UIView *theBox = textfield.superview;
        CGFloat x = theBox.frame.origin.x;
        CGFloat y = theBox.frame.origin.y;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            widthv = 538;
            heightv = 250;
            lineHeight = 1;
            UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
            if (orientation != UIInterfaceOrientationPortrait) {
                y=20.60;
            }
        }
        else {
            y=20.60;
        }
        [UIView beginAnimations:@"theBox" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView setAnimationDuration:0.27f];
        theBox.frame = CGRectMake(x, y, widthv, heightv);
        [UIView commitAnimations];
        return YES;
    }
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    UIView *theBox = textField.superview;
    [UIView beginAnimations:@"theBox" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.27f];
    theBox.center = self.view.center;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)txtView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    return YES;
}


- (void)textViewDidBeginEditing:(UITextView *)textView {
    NSBundle *bundle = [[NSBundle alloc] initWithPath:kBundlePath];
    NSString *bPath = [bundle pathForResource:@"Translations" ofType:@"bundle"];
    NSBundle *ourBundle = [[NSBundle alloc] initWithPath:bPath];
    NSString *noteStr = NSLocalizedStringFromTableInBundle(@"Note", nil, ourBundle, nil);
    CGRect aRect = self.view.frame;
    CGFloat removal = 216;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        removal = 352;
    }
    aRect.size.height -= removal;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad && orientation == UIInterfaceOrientationPortrait) {

    }
    else {
        [UIView beginAnimations:@"noteView" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView setAnimationDuration:0.27f];
        UIView *arectView = [[UIView alloc] initWithFrame:aRect];
        noteView.center = arectView.center;
        [UIView commitAnimations];

    }
    textView.delegate = self;

    if ([textView.text isEqualToString:[@"  " stringByAppendingString:noteStr]]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    NSBundle *bundle = [[NSBundle alloc] initWithPath:kBundlePath];
    NSString *bPath = [bundle pathForResource:@"Translations" ofType:@"bundle"];
    NSBundle *ourBundle = [[NSBundle alloc] initWithPath:bPath];
    NSString *noteStr = NSLocalizedStringFromTableInBundle(@"Note", nil, ourBundle, nil);
    textView.delegate = self;
    if ([textView.text isEqualToString:@""]) {
        textView.text = [@"  " stringByAppendingString:noteStr];
        textView.textColor = [UIColor colorWithRed:192.0f/255.0f green:192.0f/255.0f blue:192.0f/255.0f alpha:1.0f]; //optional
    }
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad && orientation != UIInterfaceOrientationPortrait) {
        [UIView beginAnimations:@"noteView" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView setAnimationDuration:0.27f];
        noteView.center = self.view.center;
        [UIView commitAnimations];
    }
    [textView resignFirstResponder];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSBundle *bundle = [[NSBundle alloc] initWithPath:kBundlePath];
    NSString *path = [bundle pathForResource:@"arrow" ofType:@"png"];
    UIImage *arrow = [UIImage imageWithContentsOfFile:path];
    UIImageView *arrowView = [[UIImageView alloc] initWithImage:arrow];
    [arrowView setFrame:CGRectMake(141.5, 8.5, 7, 10.5)];
    UILabel *choice = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 139.5, 17)];
    choice.font=[choice.font fontWithSize:14];
    choice.textAlignment = NSTextAlignmentRight;
    choice.text = nAccount;
    choice.textColor = [UIColor colorWithRed:192.0f/255.0f green:192.0f/255.0f blue:192.0f/255.0f alpha:1.0f];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    UIView *accessorcell = [[UIView alloc] initWithFrame:CGRectMake(103, 0, 150, 28)];
    accessorcell.backgroundColor = [UIColor clearColor];
    [accessorcell addSubview:choice];
    [accessorcell addSubview:arrowView];
    NSString *bPath = [bundle pathForResource:@"Translations" ofType:@"bundle"];
    NSBundle *ourBundle = [[NSBundle alloc] initWithPath:bPath];
    NSString *accountSt = NSLocalizedStringFromTableInBundle(@"Account", nil, ourBundle, nil);
    cell.textLabel.text = accountSt;
    cell.accessoryView = accessorcell;
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    noteOut = note.text;
    titleOut = titleField.text;
    UITableViewCell *cell = [accountName cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:YES];
    NoteAccountController *noteaccount = [[NoteAccountController alloc] init];
    NSArray *viewsToRemove = [self.view subviews];
    for (UIView *v in viewsToRemove) {
        [v setHidden:TRUE];
    }
    [note resignFirstResponder];
    [titleField resignFirstResponder];
    [self.navigationController pushViewController:noteaccount animated:YES];
}


- (void) done:(id) sender {
    NSBundle *bundle = [[NSBundle alloc] initWithPath:kBundlePath];
    NSString *bPath = [bundle pathForResource:@"Translations" ofType:@"bundle"];
    NSBundle *ourBundle = [[NSBundle alloc] initWithPath:bPath];
    NSString *noteStr = NSLocalizedStringFromTableInBundle(@"Note", nil, ourBundle, nil);
    id noteContext = [[NSClassFromString(@"NoteContext") alloc] init];
    NSArray *allAccounts = [noteContext performSelector:@selector(allStores)];
    [noteContext enableChangeLogging:YES];
    NSManagedObjectContext *context = [noteContext managedObjectContext];
    id store = [noteContext performSelector:@selector(defaultStoreForNewNote)];
    NSString *path = [@"/var/mobile/Library/Preferences" stringByAppendingPathComponent:@"com.isklikas.NoteCreatorPrefs.plist"];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:path];
    BOOL titleShown = [[dictionary objectForKey:@"SwitchCell6"] boolValue];
    if (storeNum>=0) {
        store = allAccounts[storeNum];
    }
    NoteObject *noted = (NoteObject *)[NSClassFromString(@"NSEntityDescription") insertNewObjectForEntityForName:@"Note" inManagedObjectContext:context];
    NoteBodyObject *body = (NoteBodyObject *)[NSClassFromString(@"NSEntityDescription") insertNewObjectForEntityForName:@"NoteBody" inManagedObjectContext:context];
    // set body parameters
    [noted setIsPlainText:TRUE];
    [noted performSelector:@selector(setContent:) withObject:note.text];
    body.content = note.text;
    body.owner = noted;
    noted.store = store; // reference to NoteStoreObject
    noted.integerId = [noteContext performSelector:@selector(nextIndex)];
    if ([note.text isEqual:[@"  " stringByAppendingString:noteStr]] || note.text==nil || [note.text isEqual:@""]) {
    }
    else {
        if (titleField != nil && [titleField.text isEqualToString:@""]==FALSE && titleShown==TRUE) {
            noted.title = titleField.text;
            NSString *stringbula = titleField.text;
            stringbula = [stringbula stringByAppendingString:@"\n"];
            stringbula = [stringbula stringByAppendingString:note.text];
            body.content = stringbula;
            [noted setIsPlainText:TRUE];
            [noted performSelector:@selector(setContent:) withObject:stringbula];
        }
        else {
            NSString *toCleanUp = [[note.text componentsSeparatedByString:@"\n"] objectAtIndex:0];
            noted.title = toCleanUp;
        }
        noted.summary = note.text;
        noted.body = body; // reference to NoteBodyObject
        noted.creationDate = [NSDate date];
        noted.modificationDate = [NSDate date];
        NSError *error;
        [noteContext performSelector:@selector(saveOutsideApp:) withObject:error];
        NSDictionary *title = [[NSDictionary alloc] initWithObjects:[[NSArray alloc] initWithObjects:@"  Note", @"Title", nil] forKeys:[[NSArray alloc] initWithObjects:@"Title", @"Header", nil]];
        //NSString *documentsDirectory = @"/Library/NotesCreator/";

        NSString *filePath = [bundle pathForResource:@"noteText" ofType:@"plist"];
        //NSString *process = [NSString stringWithFormat:@"chmod 777 %@", filePath];
        //const char *cProcess = [process cStringUsingEncoding:NSASCIIStringEncoding];
        //system(cProcess);

//        NSFileManager *fileManager = [NSFileManager defaultManager];
//        NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:[fileManager attributesOfItemAtPath:filePath error:nil]];
//        [attributes setObject:[NSNumber numberWithShort:0777] forKey:NSFilePosixPermissions];
//        [fileManager setAttributes:attributes ofItemAtPath:filePath error:nil];
        [title writeToFile:filePath atomically:YES];
    }
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         noteView.alpha = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         [self.view.window setHidden:TRUE];
                         [self.view.window resignFirstResponder];
                         popUp = nil;
                         [prevWin makeKeyAndVisible];
                     }];
}


- (void) cancel:(id) sender {
    NSBundle *bundle = [[NSBundle alloc] initWithPath:kBundlePath];
    NSString *bPath = [bundle pathForResource:@"Translations" ofType:@"bundle"];
    NSBundle *ourBundle = [[NSBundle alloc] initWithPath:bPath];
    NSString *path = [@"/var/mobile/Library/Preferences" stringByAppendingPathComponent:@"com.isklikas.NoteCreatorPrefs.plist"];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:path];
    BOOL scancel = [[dictionary objectForKey:@"SwitchCell2"] boolValue];
    BOOL titleShown = [[dictionary objectForKey:@"SwitchCell6"] boolValue];
    if (scancel) {
        NSDictionary *title;
        if (titleShown && [titleField.text isEqualToString:NSLocalizedStringFromTableInBundle(@"Title", nil, ourBundle, nil)]==FALSE && titleField.text != nil && [titleField.text isEqual:@""]==FALSE) {
            title = [[NSDictionary alloc] initWithObjects:[[NSArray alloc] initWithObjects:note.text, titleField.text, nil] forKeys:[[NSArray alloc] initWithObjects:@"Title", @"Header", nil]];
        }
        else {
        title = [[NSDictionary alloc] initWithObjects:[[NSArray alloc] initWithObjects:note.text, @"Title", nil] forKeys:[[NSArray alloc] initWithObjects:@"Title", @"Header", nil]];
        }
        NSString *filePath = [bundle pathForResource:@"noteText" ofType:@"plist"];
        //NSString *process = [NSString stringWithFormat:@"chmod 777 %@", filePath];
        //const char *cProcess = [process cStringUsingEncoding:NSASCIIStringEncoding];
        //system(cProcess);
        //NSFileManager *fileManager = [NSFileManager defaultManager];
        //NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:[fileManager attributesOfItemAtPath:filePath error:nil]];
        //[attributes setObject:[NSNumber numberWithShort:0777] forKey:NSFilePosixPermissions];
        //[fileManager setAttributes:attributes ofItemAtPath:filePath error:nil];
        [title writeToFile:filePath atomically:YES];
    }
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         noteView.alpha = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         [self.view.window setHidden:TRUE];
                         [self.view.window resignFirstResponder];
                         popUp = nil;
                         [prevWin makeKeyAndVisible];
                     }];
}

@end
