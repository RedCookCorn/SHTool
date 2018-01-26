//
//  ViewController.m
//  SHTool
//
//  Created by 郑浩 on 17/01/2018.
//  Copyright © 2018 郑浩. All rights reserved.
//

#import "ViewController.h"
#import "SHBaseAreaPicker.h"
#import "SHBaseManager.h"


#import "SHPhotoHelper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *bn = [UIButton buttonWithType:UIButtonTypeCustom];
    bn.frame = CGRectMake(30, 64, 100, 40);
    [bn setTitle:@"图片选择" forState:UIControlStateNormal];
    [bn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bn addTarget:self action:@selector(imageSelect) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bn];
}

- (void)imageSelect {
    [SHPhotoHelper presentFrom:self selectPhotoResult:^(UIImage *image) {
        
    }];
}


@end
