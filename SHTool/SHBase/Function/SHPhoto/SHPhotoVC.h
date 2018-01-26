//
//  SHPhotoVC.h
//  SHTool
//
//  Created by senyuhao on 26/01/2018.
//  Copyright © 2018 郑浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHPhotoVC : UIViewController

@property (nonatomic, copy) void(^imageDataBlock)(NSArray *imageDataArr);

@property (nonatomic, assign) NSInteger maxSelect;

@end
