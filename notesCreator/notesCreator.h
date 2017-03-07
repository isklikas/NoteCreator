//
//  nn.h
//  notesCreator
//
//  Created by Yannis on 16/01/14.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <libactivator/libactivator.h>
//#import "Notes/Notes.h"
#import "NoteController.h"

@interface notesCreator : NSObject<LAListener, UIAlertViewDelegate> {
@private
}
extern UIWindow *popUp;
extern UIWindow *prevWin;
@end
