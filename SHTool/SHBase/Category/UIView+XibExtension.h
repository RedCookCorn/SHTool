//
//  UIView+XibExtension.h
//  SHTool
//
//  Created by senyuhao on 18/01/2018.
//  Copyright © 2018 郑浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XibExtension)

@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

@property (nonatomic, strong) IBInspectable UIColor *layerBorderColor;

@property (nonatomic, assign) IBInspectable CGFloat layerBorderWidth;

@end
