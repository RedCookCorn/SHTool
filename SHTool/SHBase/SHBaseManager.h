//
//  SHBaseManager.h
//  SHTool
//
//  Created by senyuhao on 19/01/2018.
//  Copyright © 2018 郑浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SHBaseManager : NSObject

/**
 common picker color
 */
@property (nonatomic, strong) UIColor *commonPickerCancelColor;
@property (nonatomic, strong) UIColor *commonPickerSureColor;
@property (nonatomic, strong) UIColor *commonPickerSeperatorColor;
@property (nonatomic, strong) UIColor *commonPickerChooseBgColor;

// photo设置
@property (nonatomic, strong) UIColor *commonSHPhotoBackgroudColor;
@property (nonatomic, strong) UIImage *commonSHPhotoTitleImageUp;
@property (nonatomic, strong) UIImage *commonSHPhotoTitleImageDown;
@property (nonatomic, strong) UIColor *commonSHPhotoTitleColor;


+ (instancetype)shareInstance;

+ (CGFloat)screenWidth;
+ (CGFloat)screenHeight;



@end
