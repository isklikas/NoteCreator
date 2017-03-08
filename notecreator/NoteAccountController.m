//
//  NoteAccountController.m
//  CallShare
//
//  Created by Yannis on 12/8/13.
//
//
#define kBundlePath @"/Library/MobileSubstrate/DynamicLibraries/com.isklikas.NoteCreator.bundle"
#import "NoteAccountController.h"
NSInteger previousSelection=0;
NSString *nAccount;
NSInteger storeNum=-1;
NSString *noteBodyT;
UITableView *accountName;
@interface NoteAccountController ()

@end

@implementation NoteAccountController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        NSArray *viewsToRemove = [self.view subviews];
        for (UIView *v in viewsToRemove) {
            [v removeFromSuperview];
        }
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self viewDidLoad];
    }
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return YES;
    }
    else {
        return NO;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (orientation != UIInterfaceOrientationPortrait) {
        screenWidth = screenRect.size.height;
        screenHeight = screenRect.size.width;
    }
    UIImageView *transparentBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    NSBundle *bundle = [[NSBundle alloc] initWithPath:kBundlePath];
    NSString *imagePath = [bundle pathForResource:@"bg" ofType:@"png"];
    UIImage *bg = [UIImage imageWithContentsOfFile:imagePath];
    [transparentBG setImage:bg];
    [self.view addSubview:transparentBG];
    self.title = @"Note";
    [self.navigationController setNavigationBarHidden:TRUE animated:FALSE];
    UIView *noteView = [self createNote];
    noteView.center = transparentBG.center;
    [self.view addSubview:noteView];
}


-(UIView *)createNote {
    NSBundle *bundle = [[NSBundle alloc] initWithPath:kBundlePath];
    NSString *bPath = [bundle pathForResource:@"Translations" ofType:@"bundle"];
    NSBundle *ourBundle = [[NSBundle alloc] initWithPath:bPath];
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
    noteNavigation.topItem.title = @"Note";
    NSString *imagePath = [bundle pathForResource:@"back" ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage: [image stretchableImageWithLeftCapWidth:7.0 topCapHeight:0.0] forState:UIControlStateNormal];
    button.frame= CGRectMake(-8.0, 1.0, image.size.width/2, image.size.height/2);
    [button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *textButton = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString *back = NSLocalizedStringFromTableInBundle(@"Back", nil, ourBundle, nil);
    [textButton setTitle:back forState:UIControlStateNormal];
    textButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [textButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    textButton.frame = CGRectMake(image.size.width/2-5, 2.0, 75, image.size.height/2);
    [textButton setTitleColor:[UIColor colorWithRed:0/255.0 green:121/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
    [textButton setTitleColor:[UIColor colorWithRed:0/255.0 green:64/255.0 blue:136/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 30+(image.size.width+100)/2, image.size.height/2) ];
    [v addSubview:button];
    [v addSubview:textButton];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:v];
    ////////////////////////////////////
    noteNavigation.topItem.leftBarButtonItem = backButton;
    NSString *accountStr = NSLocalizedStringFromTableInBundle(@"Account", nil, ourBundle, nil);
    UINavigationItem *navigItem = [[UINavigationItem alloc] initWithTitle:accountStr];
    navigItem.leftBarButtonItem = backButton;
    noteNavigation.items = [NSArray arrayWithObjects: navigItem,nil];
    [noteView addSubview:noteNavigation];
    nAtable = [[UITableView alloc] initWithFrame:CGRectMake(0, 44+lineHeight, widthv, heightv-lineHeight-44) style:UITableViewStylePlain];
    nAtable.delegate = self;
    nAtable.dataSource = self;
    [noteView addSubview:nAtable];
    noteView.layer.cornerRadius = 5;
    noteView.layer.masksToBounds = YES;
    LineCreator *topLine = [[LineCreator alloc] initWithFrame:CGRectMake(0, 44, widthv, lineHeight)];
    topLine.backgroundColor = [UIColor colorWithRed:192.0f/255.0f green:192.0f/255.0f blue:192.0f/255.0f alpha:1.0f];
    [noteView addSubview:topLine];
    return noteView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    id noteContext = [[NSClassFromString(@"NoteContext") alloc] init];
    NSArray *allAccounts = [noteContext performSelector:@selector(allStores)];
    return [allAccounts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    id noteContext = [[NSClassFromString(@"NoteContext") alloc] init];
    NSArray *allAccounts = [noteContext performSelector:@selector(allStores)];
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    id store = [noteContext performSelector:@selector(defaultStoreForNewNote)];
    store = allAccounts[indexPath.row];
    NSString *output = [[store performSelector:@selector(account)] performSelector:@selector(name)];
    NSBundle *bundle = [[NSBundle alloc] initWithPath:kBundlePath];
    NSString *bPath = [bundle pathForResource:@"Translations" ofType:@"bundle"];
    NSBundle *ourBundle = [[NSBundle alloc] initWithPath:bPath];
    if ([output isEqual:@"LOCAL_NOTES_ACCOUNT"]) {
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            NSString *deviceacc = NSLocalizedStringFromTableInBundle(@"Omiphone", nil, ourBundle, nil);
            output = deviceacc;
        }
        else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            NSString *deviceacc = NSLocalizedStringFromTableInBundle(@"Omipad", nil, ourBundle, nil);
            output = deviceacc;

        }
        else {
            NSString *deviceacc = NSLocalizedStringFromTableInBundle(@"Omitouch", nil, ourBundle, nil);
            output = deviceacc;
        }
    }
    cell.textLabel.text = output;
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *select = [NSIndexPath indexPathForRow:previousSelection inSection:0];
    UITableViewCell *cell = [nAtable cellForRowAtIndexPath:select];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell = [nAtable cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    //[cell setSelected:NO animated:YES];
    //[cell setHighlighted:NO animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    nAccount = cell.textLabel.text;
    previousSelection = indexPath.row;
    storeNum = indexPath.row;
    [accountName reloadData];
}


- (void) back:(id) sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
    [accountName reloadData];
    //[self.activity activityDidFinish:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
