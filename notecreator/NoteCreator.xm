#import "NoteCreator.h"
UIWindow *popUp;
UIWindow *prevWin;

#define LASendEventWithName(eventName) \
	[LASharedActivator sendEventToListener:[LAEvent eventWithName:eventName mode:[LASharedActivator currentEventMode]]]

static NSString *NoteCreator_eventName = @"isklikas.noteCreator";

@interface NoteCreatorDataSource : NSObject <LAEventDataSource> {}

+ (id)sharedInstance;

@end

@interface NoteCreator ()

@end

@implementation NoteCreator

- (BOOL)dismiss {
	if (popUp) {
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

- (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event {
	if (![self dismiss]) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
        popUp = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
        popUp.windowLevel = UIWindowLevelAlert+1;
        popUp.userInteractionEnabled = YES;
        NoteScreenContainer *container = [[NoteScreenContainer alloc] init];
        popUp.rootViewController = container;
        prevWin = [[UIApplication sharedApplication] keyWindow];
        [prevWin setUserInteractionEnabled:TRUE];
        [popUp makeKeyAndVisible];
		    [event setHandled:YES];
	}
}

- (void)activator:(LAActivator *)activator abortEvent:(LAEvent *)event {
	// Called when event is escalated to higher event
	[self dismiss];
}

- (void)activator:(LAActivator *)activator otherListenerDidHandleEvent:(LAEvent *)event {
	// Called when other listener receives an event
	[self dismiss];
}

+ (void)load {
	if ([LASharedActivator isRunningInsideSpringBoard]) {
		[LASharedActivator registerListener:[self new] forName:@"isklikas.noteCreator"];
	}
}

@end

@implementation NoteCreatorDataSource

+ (id)sharedInstance {
	static id sharedInstance = nil;
	static dispatch_once_t token = 0;
	dispatch_once(&token, ^{
		sharedInstance = [self new];
	});
	return sharedInstance;
}

+ (void)load {
	[self sharedInstance];
}

- (id)init {
	if ((self = [super init])) {
		// Register our event
		if (LASharedActivator.isRunningInsideSpringBoard) {
			[LASharedActivator registerEventDataSource:self forEventName:NoteCreator_eventName];
		}
	}
	return self;
}

- (void)dealloc {
	if (LASharedActivator.isRunningInsideSpringBoard) {
		[LASharedActivator unregisterEventDataSourceWithEventName:NoteCreator_eventName];
	}
	//[super dealloc];
}

- (NSString *)localizedTitleForEventName:(NSString *)eventName {
	return @"NoteCreator";
}

- (NSString *)localizedGroupForEventName:(NSString *)eventName {
	return @"NoteCreator";
}

- (NSString *)localizedDescriptionForEventName:(NSString *)eventName {
	return @"Creating a Note";
}
/*
- (BOOL)eventWithNameIsHidden:(NSString *)eventName {
	return NO;
}
*/
/*
- (BOOL)eventWithNameRequiresAssignment:(NSString *)eventName {
	return NO;
}
*/
- (BOOL)eventWithName:(NSString *)eventName isCompatibleWithMode:(NSString *)eventMode {
	return YES;
}
/*
- (BOOL)eventWithNameSupportsUnlockingDeviceToSend:(NSString *)eventName {
	return NO;
}
*/

@end

////////////////////////////////////////////////////////////////

// Event dispatch

/*
%hook ClassName

// Hooking an instance method with an argument.
- (void)messageName:(int)argument {
	LASendEventWithName(NoteCreator_eventName);
	%orig();
}

%end
*/
