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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    SHBaseAreaPicker *areapicker = [[SHBaseAreaPicker alloc] initWithFrame:CGRectMake(0, [SHBaseManager screenHeight] - 265, [SHBaseManager screenWidth], 265) selectBlock:^(id sender) {
        NSLog(@"sender = %@", sender);
    }];
    [self.view addSubview:areapicker];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
