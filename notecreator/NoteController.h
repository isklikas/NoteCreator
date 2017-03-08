//
//  NoteController.h
//  CallShare
//
//  Created by Yannis on 12/9/13.
//
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>
//#import "Notes/Notes.h"
#import <QuartzCore/QuartzCore.h>
#import "NoteAccountController.h"
#import "LineCreator.h"
#import "NoteCreator.h"

@interface NoteController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, UITextFieldDelegate> {
    UITextView *note;
    UITextField *titleField;
}
extern UITableView *accountName;
extern NSString *noteOut;
@end
