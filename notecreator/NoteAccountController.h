//
//  NoteAccountController.h
//  CallShare
//
//  Created by Yannis on 12/8/13.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
//#import "Notes/Notes.h"
#import "LineCreator.h"
#import "NoteController.h"
#import "NoteAccountController.h"

@interface NoteAccountController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    UITableView *nAtable;
}
extern NSString *nAccount;
extern NSInteger storeNum;

@end
