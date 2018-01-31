//
//  SHBaseActionSheet.h
//  SHTool
//
//  Created by 四郎 on 31/01/2018.
//  Copyright © 2018 郑浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHBaseActionSheet : NSObject

+ (void)actionSheetConfirm:(void(^)(NSInteger tag)) block
                     title:(NSString *)title
                     color:(UIColor *)titleColor
                    cancel:(NSString *)cancelTitle
                     color:(UIColor *)cancelColor
          destructiveTitle:(NSString *)destructiveTitle
                     color:(UIColor *)destructiveColor
               otherTitles:(NSArray *)otherTitles
                     color:(UIColor *)otherColor
                    inView:(UIView *)viewToShow;

@end
