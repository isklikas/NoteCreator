#import "NoteScreenContainer.h"

@interface NoteScreenContainer()
@end

@implementation NoteScreenContainer

- (void)viewDidLoad {
	  UIImageView *transparentBG = [[UIImageView alloc] initWithFrame:self.view.bounds];
    UIImage *bg = [UIImage imageWithContentsOfFile:[[[NoteFileManager alloc] init] objectOfNameAtBundle:@"bg.png"]];
    [transparentBG setImage:bg];
    [self.view addSubview:transparentBG];
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
    self.noteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, widthv, heightv)];
		self.noteView.layer.cornerRadius = 5;
    self.noteView.layer.masksToBounds = YES;
    //[self.noteView setBackgroundColor:[UIColor whiteColor]];
		[self.view addSubview:self.noteView];
		NoteContentController *content = [[NoteContentController alloc] init];
		UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:content];
    [navigationController willMoveToParentViewController:self];
    navigationController.view.frame = self.noteView.frame;  //Set a frame or constraints
    [self.noteView addSubview:navigationController.view];
    [self addChildViewController:navigationController];
    [navigationController didMoveToParentViewController:self];
}

- (void)viewWillAppear:(BOOL)animated {
	  self.noteView.center = self.view.center;
}

@end