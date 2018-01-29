//
//  SHPhotoVC.h
//  SHTool
//
//  Created by senyuhao on 26/01/2018.
//  Copyright © 2018 郑浩. All rights reserved.
//

#import "SHBaseViewController.h"

@interface SHPhotoVC : SHBaseViewController

@property (nonatomic, copy) void(^imageDataBlock)(NSArray *imageDataArr);

@property (nonatomic, assign) NSInteger maxSelect;

@end
