//
//  LineCreator.m
//  CallShare
//
//  Created by Yannis on 12/9/13.
//
//

#import "LineCreator.h"

@implementation LineCreator

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:192.0f/255.0f green:192.0f/255.0f blue:192.0f/255.0f alpha:1.0f].CGColor);
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, 2.0);
    CGContextMoveToPoint(context, 0,0); //start at this point
    CGContextAddLineToPoint(context, 20, 20); //draw to this point
    // and now draw the Path!
    CGContextStrokePath(context);
}


@end
