//
//  UIView+QM.m
//  AppFrame
//

#import "UIView+QM.h"

@implementation UIView (QM)

- (UIViewController *)rootViewcontroller
{
    UIResponder *responder = [self nextResponder];
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}

@end
