//
//  UIButton+SHExtension.h
//  SHTool
//
//  Created by senyuhao on 24/02/2018.
//  Copyright © 2018 郑浩. All rights reserved.
//


#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, SHButtonInsetStyle) {
    SHButtonInsetStyleTop,
    SHButtonInsetStyleLeft,
    SHButtonInsetStyleBottom,
    SHButtonInsetStyleRight
};

@interface UIButton (SHExtension)

/**
 base on MKButtonCategory on github
 */
- (void)layoutButtonWithEdgeInsetsStyle:(SHButtonInsetStyle)style
                        imageTitleSpace:(CGFloat)space;

@end
