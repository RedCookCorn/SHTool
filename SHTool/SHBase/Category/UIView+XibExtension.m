//
//  UIView+XibExtension.m
//  SHTool
//
//  Created by senyuhao on 18/01/2018.
//  Copyright © 2018 郑浩. All rights reserved.
//

#import "UIView+XibExtension.h"

@implementation UIView (XibExtension)

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0;
}

- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}

- (void)setLayerBorderColor:(UIColor *)layerBorderColor {
    self.layer.borderColor = layerBorderColor.CGColor;
    self.layer.masksToBounds = 1;
}

- (UIColor *)layerBorderColor {
    return nil;
}

- (void)setLayerBorderWidth:(CGFloat)layerBorderWidth {
    self.layer.borderWidth = layerBorderWidth;
}

- (CGFloat)layerBorderWidth {
    return self.layer.borderWidth;
}

@end
