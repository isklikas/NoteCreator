#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <libactivator/libactivator.h>
#include <dispatch/dispatch.h>
//#import "Notes/Notes.h"
#import "NoteController.h"

@interface NoteCreator : NSObject<LAListener, UIAlertViewDelegate> {
@private
}
extern UIWindow *popUp;
extern UIWindow *prevWin;
@end
