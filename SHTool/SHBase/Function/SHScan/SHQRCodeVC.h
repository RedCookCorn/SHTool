//
//  SHQRCodeVC.h
//  SHTool
//
//  Created by senyuhao on 09/02/2018.
//  Copyright © 2018 郑浩. All rights reserved.
//

#import "SHBaseViewController.h"

@interface SHQRCodeVC : SHBaseViewController

@property (nonatomic, copy) void(^resultBlock)(NSString *value);

@end
