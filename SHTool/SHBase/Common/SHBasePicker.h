//
//  SHBasePicker.h
//  SHTool
//
//  Created by senyuhao on 19/01/2018.
//  Copyright © 2018 郑浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHBasePicker : UIView

@property (nonatomic, copy) void(^sureBlock)(id sender);
@property (nonatomic, copy) void(^cancelBlock)(id sender);
@property (nonatomic, copy) void(^selectBlock)(id sender);

@property (nonatomic, copy) NSArray *listItems;

- (void)configDelegate:(id)sender;

- (void)show;

- (void)cancelResponse:(id)sender;

- (void)sureResponse:(id)sender;
@end
