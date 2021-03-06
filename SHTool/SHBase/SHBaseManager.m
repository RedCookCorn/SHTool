//
//  SHBaseManager.m
//  SHTool
//
//  Created by senyuhao on 19/01/2018.
//  Copyright © 2018 郑浩. All rights reserved.
//

#import "SHBaseManager.h"
#import "UIColor+SHExtension.h"

@implementation SHBaseManager

static id _instance;
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (id)init {
    self = [super init];
    if (self) {
        _commonPickerSureColor = [UIColor colorWithHexs:0x379aff];
        _commonPickerCancelColor = [UIColor colorWithHexs:0xdcdcdc];
        _commonPickerSeperatorColor = [UIColor colorWithHexs:0x333333];
        
        _commonSHPhotoBackgroudColor = [UIColor colorWithHexs:0xf1f1f1];
        _commonSHPhotoTitleImageUp = [UIImage imageNamed:@"sh_photo_title_down"];
        _commonSHPhotoTitleImageDown = [UIImage imageNamed:@"sh_photo_title_down"];
        _commonSHPhotoTitleColor = [UIColor blackColor];
        
        // 设置ActionSheet属性
        _commonSheetBgColor = [UIColor colorWithRed:214.0/255.0f green:215.0/255.0f blue:222/255.0f alpha:1.0f];
        _commonSheetArrayButtonColor = [UIColor colorWithRed:254/255.0f green:254/255.0f blue:254/255.0f alpha:1.0f];
        _commonSheetSeperatorColor = [UIColor colorWithRed:206/255.0f green:206/255.0f blue:206/255.0f alpha:1.0f];
        _commonSheetButtonHeight = 44.0f;
    }
    return self;
}

+ (CGFloat)screenWidth {
    return [[UIScreen mainScreen] bounds].size.width;
}

+ (CGFloat)screenHeight {
    return [[UIScreen mainScreen] bounds].size.height;
}

@end
