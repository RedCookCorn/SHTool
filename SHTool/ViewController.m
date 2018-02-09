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
#import "SHTool.h"
#import "SHQRCodeVC.h"

@interface ViewController ()

@property (nonatomic, strong) UITextField *encodeField;
@property (nonatomic, strong) UITextField *keyField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *bn = [UIButton buttonWithType:UIButtonTypeCustom];
    bn.frame = CGRectMake(0, 64, 100, 40);
    [bn setTitle:@"图片选择" forState:UIControlStateNormal];
    [bn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bn addTarget:self action:@selector(imageSelect) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bn];
    
    UIButton *bnScan = [UIButton buttonWithType:UIButtonTypeCustom];
    bnScan.frame = CGRectMake(180, 64, 100, 40);
    [bnScan setTitle:@"扫描" forState:UIControlStateNormal];
    [bnScan setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bnScan addTarget:self action:@selector(scanSelect) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bnScan];
    
    
    _encodeField = [[UITextField alloc] initWithFrame:CGRectMake(0, 110, 100, 35)];
    _encodeField.placeholder = @"请输入加密文字";
    [self.view addSubview:_encodeField];
    
    _keyField = [[UITextField alloc] initWithFrame:CGRectMake(0, 150, 100, 35)];
    _keyField.placeholder = @"请输入加密key值";
    [self.view addSubview:_keyField];
    
    UIButton *MD5bn = [UIButton buttonWithType:UIButtonTypeCustom];
    MD5bn.frame = CGRectMake(0, 200, 100, 40);
    [MD5bn setTitle:@"MD5加密" forState:UIControlStateNormal];
    [MD5bn setTitle:@"MD5解密" forState:UIControlStateSelected];
    [MD5bn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [MD5bn addTarget:self action:@selector(md5Action:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:MD5bn];
    
    NSLog(@"result = %@",[SHTool encodeMd5String:@"123"]);

}

- (void)imageSelect {
    [SHPhotoHelper presentFrom:self selectPhotoResult:^(NSArray *imageArray) {
        NSLog(@"images = %@", imageArray);
    }];
}

- (void)scanSelect {
    SHQRCodeVC *vc = [SHQRCodeVC new];
    vc.resultBlock = ^(NSString *value) {
        NSLog(@"value = %@", value);
    };
    [self presentViewController:vc animated:YES completion:nil];
}

@end
