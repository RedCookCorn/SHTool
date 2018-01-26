//
//  SHPhotoHelper.h
//  SHTool
//
//  Created by senyuhao on 26/01/2018.
//  Copyright © 2018 郑浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHPhotoHelper : NSObject

// 单选 present
+ (void)presentFrom:(UIViewController *)vc selectPhotoResult:(void(^)(UIImage *image))resultBlock;

// 单选 navigation 
+ (void)navigationFrom:(UIViewController *)vc selectPhotoResult:(void(^)(UIImage *image))resultBlock;

@end
