//
//  SHBaseAreaPicker.m
//  SHTool
//
//  Created by senyuhao on 22/01/2018.
//  Copyright © 2018 郑浩. All rights reserved.
//

#import "SHBaseAreaPicker.h"
#import "SHBaseManager.h"

#define LOADTYPE        @"load_area_type"
#define LOADSELECT      @"load_area_select"

@interface SHBaseAreaPicker()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, assign) NSInteger provinceSelect;
@property (nonatomic, assign) NSInteger citySelect;
@property (nonatomic, assign) NSInteger areSelect;

@property (nonatomic, copy) NSArray *mainArray;
@property (nonatomic, strong) NSMutableArray *provinceArray;
@property (nonatomic, strong) NSMutableArray *cityArray;
@property (nonatomic, strong) NSMutableArray *areaArray;

@end

@implementation SHBaseAreaPicker

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _provinceSelect = 0;
        _citySelect = 0;
        _areSelect = 0;
        
        _provinceArray = [NSMutableArray new];
        _cityArray = [NSMutableArray new];
        _areaArray = [NSMutableArray new];
        [self loadMainArray];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                  selectBlock:(void(^)(id sender))selectBlock {
    self = [super initWithFrame:frame];
    if (self) {
        _provinceSelect = 0;
        _citySelect = 0;
        _areSelect = 0;
        
        self.selectBlock = selectBlock;
        
        _provinceArray = [NSMutableArray new];
        _cityArray = [NSMutableArray new];
        _areaArray = [NSMutableArray new];
        [self loadMainArray];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
                  selectBlock:(void(^)(id sender))selectBlock {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _provinceSelect = 0;
        _citySelect = 0;
        _areSelect = 0;
        
        self.selectBlock = selectBlock;
        
        _provinceArray = [NSMutableArray new];
        _cityArray = [NSMutableArray new];
        _areaArray = [NSMutableArray new];
        [self loadMainArray];
    }
    return self;
}

- (void)loadMainArray {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CCA" ofType:@"plist"];
    _mainArray = [NSArray arrayWithContentsOfFile:path];
    for (int i = 0; i < [self.mainArray count]; i++) {
        [_provinceArray addObject:_mainArray[i][@"state"]];
    }
    [self configDelegate:self];
    [self selectResponse];
}

- (void)cancelResponse:(UIButton *)sender {
    [super cancelResponse:sender];
    if (self.cancelBlock) {
        self.cancelBlock(nil);
    }
    [self removeFromSuperview];
}

- (NSArray *)arrayOfSelectPicker {
    NSString *province = _mainArray[_provinceSelect][@"state"];
    NSString *city = _mainArray[_provinceSelect][@"cities"][_citySelect][@"city"];
    if ([_mainArray[_provinceSelect][@"cities"][_citySelect][@"areas"] count] > _areSelect) {
        NSString *area = _mainArray[_provinceSelect][@"cities"][_citySelect][@"areas"][_areSelect][@"county"];
        return @[province, city, area];
    } else {
        return @[province, city, @""];
    }
}

- (void)sureResponse:(UIButton *)sender {
    [super sureResponse:sender];
    if (self.sureBlock) {
        self.sureBlock([self arrayOfSelectPicker]);
    }
    [self removeFromSuperview];
}

- (void)selectResponse {
    if (self.selectBlock) {
        self.selectBlock([self arrayOfSelectPicker]);
    }
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return [_mainArray count];
    } else if (component == 1) {
        if ([_mainArray count] > _provinceSelect) {
            return [_mainArray[_provinceSelect][@"cities"] count];
        }
    } else if (component == 2) {
        if ([_mainArray[_provinceSelect][@"cities"] count] > _citySelect) {
            return [_mainArray[_provinceSelect][@"cities"][_citySelect][@"areas"] count];
        }
    }
    return 0;
}

#pragma mark -UIPickerViewDelegate
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return _mainArray[row][@"state"];
    } else if (component == 1) {
        return _mainArray[_provinceSelect][@"cities"][row][@"city"];
    } else {
        return _mainArray[_provinceSelect][@"cities"][_citySelect][@"areas"][row][@"county"];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        if (row != _provinceSelect) {
            _provinceSelect = row;
            _citySelect = 0;
            _areSelect = 0;
            [pickerView reloadAllComponents];
            [pickerView selectRow:0 inComponent:1 animated:NO];
            [pickerView selectRow:0 inComponent:2 animated:NO];
        }
    } else if (component == 1) {
        if (row != _citySelect) {
            _citySelect = row;
            _areSelect = 0;
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:NO];
        }
    } else {
        _areSelect = row;
    }
    [self selectResponse];
}

@end
