//
//  HomeVC.m
//  SHTool
//
//  Created by senyuhao on 28/02/2018.
//  Copyright © 2018 郑浩. All rights reserved.
//

#import "HomeVC.h"
#import "SHPhotoHelper.h"
#import "SHQRCodeVC.h"

@interface HomeVC ()

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

#pragma mark - Action
- (IBAction)imageSelectAction:(UIButton *)sender {
    [SHPhotoHelper presentFrom:self selectPhotoResult:^(NSArray *imageArray) {
        NSLog(@"images = %@", imageArray);
    }];
}

- (IBAction)scanAction:(UIButton *)sender {
    SHQRCodeVC *vc = [SHQRCodeVC new];
    vc.resultBlock = ^(NSString *value) {
        NSLog(@"value = %@", value);
    };
    [self presentViewController:vc animated:YES completion:nil];
}

@end
