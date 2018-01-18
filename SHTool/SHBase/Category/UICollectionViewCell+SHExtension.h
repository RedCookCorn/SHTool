//
//  UICollectionViewCell+SHExtension.h
//  SHTool
//
//  Created by senyuhao on 18/01/2018.
//  Copyright © 2018 郑浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionViewCell (SHExtension)

+ (NSString *)identifyForCell;

+ (UINib *)nib;

- (UIViewController *)currentController;

@end
