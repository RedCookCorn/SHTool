//
//  SHBaseTextField.h
//  SHTool
//
//  Created by 四郎 on 31/01/2018.
//  Copyright © 2018 郑浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHBaseTextField : UITextField

// 限制最大输入个数
@property (nonatomic, assign) NSInteger maxLength;

// 输入小数点后两位,并限制最多11位
@property (nonatomic, assign) BOOL onlyPointNumber;

// 设置该属性：YES:则可以设置屏蔽部分操作 NO:则屏蔽所有操作
@property (nonatomic, assign) BOOL showMenuController;

// 单独设置TextField是否可以编辑
@property (nonatomic, assign) BOOL canPasteForTextField;
@property (nonatomic, assign) BOOL canSelectAllForTextField;
@property (nonatomic, assign) BOOL canCopyForTextField;

@end
