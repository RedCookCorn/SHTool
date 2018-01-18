//
//  SHBaseToast.h
//  SHTool
//
//  Created by 郑浩 on 18/01/2018.
//  Copyright © 2018 郑浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SHBaseToast : NSObject

+ (void)showToast:(NSString *)message;

+ (void)showToast:(NSString *)message inView:(UIView *)view;

+ (void)showToast:(NSString *)message inView:(UIView *)view duration:(NSInteger)duration;

+ (void)dismissToast:(UIView *)view;

@end
