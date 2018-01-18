//
//  UITableViewCell+SHExtension.m
//  SHTool
//
//  Created by senyuhao on 18/01/2018.
//  Copyright © 2018 郑浩. All rights reserved.
//

#import "UITableViewCell+SHExtension.h"

@implementation UITableViewCell (SHExtension)

+ (NSString *)identifyForCell {
    return NSStringFromClass(self);
}

+ (UINib *)nib {
    return [UINib nibWithNibName:[self identifyForCell] bundle:nil];
}

- (UIViewController *)currentController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
