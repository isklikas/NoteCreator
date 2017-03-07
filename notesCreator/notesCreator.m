//
//  notesCreator.m
//  notesCreator
//
//  Created by Yannis on 14/01/14.
//  Copyright (c) 2014 isklikas. All rights reserved.
//

// LibActivator by Ryan Petrich
// See https://github.com/rpetrich/libactivator

#import "notesCreator.h"
UINavigationController *navigationController;
UIWindow *popUp;
UIWindow *prevWin;

@interface notesCreator ()

@end

@implementation notesCreator


- (BOOL)dismiss
{
	if (popUp)
	{
        [popUp setHidden:TRUE];
        [popUp endEditing:YES];
        [popUp resignFirstResponder];
        popUp = nil;
        if (prevWin) {
            [prevWin makeKeyAndVisible];
        }
		return YES;
	}
	return NO;
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
}

- (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event
{
	if (![self dismiss])
	{
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
        popUp = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
        popUp.windowLevel = UIWindowLevelAlert+1;
        popUp.userInteractionEnabled = YES;
        NoteController *notes = [[NoteController alloc] init];
        navigationController = [[UINavigationController alloc] initWithRootViewController:notes];
        popUp.rootViewController = navigationController;
        prevWin = [[UIApplication sharedApplication] keyWindow];
        [prevWin setUserInteractionEnabled:TRUE];
        [popUp makeKeyAndVisible];
		[event setHandled:YES];
	}
}

- (void)activator:(LAActivator *)activator abortEvent:(LAEvent *)event
{
	// Called when event is escalated to higher event
	[self dismiss];
}

- (void)activator:(LAActivator *)activator otherListenerDidHandleEvent:(LAEvent *)event
{
	// Called when other listener receives an event
	[self dismiss];
}

- (void)activator:(LAActivator *)activator receiveDeactivateEvent:(LAEvent *)event
{
	// Called when the home button is pressed.
	// If showing UI, then dismiss it and call setHandled:.
    //[self dismiss];
	//if ([self dismiss])
	//	[event setHandled:YES];
}


+ (void)load
{
	@autoreleasepool
	{
		[[LAActivator sharedInstance] registerListener:[self new] forName:@"isklikas.notesCreator"];
	}
}

@end
