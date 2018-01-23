//
//  SHBasePicker.m
//  SHTool
//
//  Created by senyuhao on 19/01/2018.
//  Copyright © 2018 郑浩. All rights reserved.
//

#import "SHBasePicker.h"
#import "SHBaseManager.h"

@interface UIButton (SHBasePicker)

@end

@implementation UIButton (SHBasePicker)

+ (UIButton *)basePickerBnFrame:(CGRect)frame
                          title:(NSString *)title
                     titleColor:(UIColor *)titleColor {
    UIButton *bn = [[UIButton alloc] initWithFrame:frame];
    [bn setTitle:title forState:UIControlStateNormal];
    [bn setTitleColor:titleColor forState:UIControlStateNormal];
    [bn setBackgroundColor:[SHBaseManager shareInstance].commonPickerChooseBgColor];
    return bn;
}

@end

@interface SHBasePicker()

@property (nonatomic, strong) UIPickerView *basePicker;
@property (nonatomic, assign) NSInteger pickerRow;
@property (nonatomic, assign) NSInteger pickerComponent;

@end

@implementation SHBasePicker

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configBaseView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configBaseView];
    }
    return self;
}

- (void)configBaseView {
    UIButton *bnCancel = [UIButton basePickerBnFrame:CGRectMake(0, 0, [SHBaseManager screenWidth]/2-0.25, 44)
                                               title:@"取消"
                                          titleColor:[SHBaseManager shareInstance].commonPickerCancelColor];
    [bnCancel addTarget:self action:@selector(cancelResponse:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bnCancel];
    
    UIButton *bnSure = [UIButton basePickerBnFrame:CGRectMake([SHBaseManager screenWidth]/2+0.25, 0, [SHBaseManager screenWidth]/2-0.25, 44)
                                             title:@"确定"
                                        titleColor:[SHBaseManager shareInstance].commonPickerSureColor];
    [bnSure addTarget:self action:@selector(sureResponse:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bnSure];
    
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake([SHBaseManager screenWidth]/2-0.25, 0, 0.5, 44)];
    line1.backgroundColor = [SHBaseManager shareInstance].commonPickerSeperatorColor;
    [self addSubview:line1];
    
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 44, [SHBaseManager screenWidth], 0.5)];
    line2.backgroundColor = [SHBaseManager shareInstance].commonPickerSeperatorColor;
    [self addSubview:line2];
    
    _basePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44.5, [SHBaseManager screenWidth], 216.5)];
    _basePicker.backgroundColor = [UIColor whiteColor];
    [self addSubview:_basePicker];
}

- (void)show {
    
}

- (void)configDelegate:(id)sender {
    _basePicker.delegate = sender;
    _basePicker.dataSource = sender;
}

- (void)cancelResponse:(id)sender {
    
}

- (void)sureResponse:(id)sender {
    
}










@end
