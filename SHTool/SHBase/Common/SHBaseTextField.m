//
//  SHBaseTextField.m
//  SHTool
//
//  Created by 四郎 on 31/01/2018.
//  Copyright © 2018 郑浩. All rights reserved.
//

#import "SHBaseTextField.h"

@interface SHBaseTextField()<UITextFieldDelegate>


@end


@implementation SHBaseTextField

/// 屏蔽复制、粘贴、全选等操作
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (!self.showMenuController) {
        if ([UIMenuController sharedMenuController]) {
            [UIMenuController sharedMenuController].menuVisible = self.showMenuController;
        }
        return self.showMenuController;
    } else {
        if (action == @selector(paste:)) {
            return self.canPasteForTextField;
        } else if (action == @selector(selectAll:)) {
            return self.canSelectAllForTextField;
        } else if (action == @selector(copy:)) {
            return self.canCopyForTextField;
        } else {
            return [self canPerformAction:action withSender:sender];
        }
    }
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.showMenuController = YES;
        self.canPasteForTextField = YES;
        self.canSelectAllForTextField = YES;
        self.canCopyForTextField = YES;
        self.delegate = self;
        
        [self addTarget:self action:@selector(fieldEdit:) forControlEvents:UIControlEventAllEditingEvents];
    }
    return self;
}

- (void)fieldEdit:(UITextField *)sender {
    if (self.maxLength <= 0) {
        return;
    } else {
        sender.text = [sender.text substringToIndex:self.maxLength-1];
    }
}

#define myDotNumbers            @"0123456789.\n"
#define myNumbers               @"0123456789\n"

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (self.onlyPointNumber) {
        NSCharacterSet *cs;
        // 判断输入内容
        if (![string isEqualToString:@""]) {
            if ([textField.text length] == 1 && [textField.text isEqualToString:@"0"] && [string isEqualToString:@"0"]) {
                return NO;
            }
            
            NSInteger dotLocation = [textField.text rangeOfString:@"."].location;
            if (dotLocation == NSNotFound && range.location != 0) {
                cs = [[NSCharacterSet characterSetWithCharactersInString:myDotNumbers] invertedSet];
                if (range.location >= 9) {
                    if ([string isEqualToString:@"."] && range.location == 9) {
                        return YES;
                    }
                    return NO;
                }
            } else {
                cs = [[NSCharacterSet characterSetWithCharactersInString:myNumbers] invertedSet];
            }
            
            NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
            BOOL basicText = [string isEqualToString:filtered];
            if (!basicText) {
                NSLog(@"只能输入数字和小数点");
                return NO;
            }
            
            if (dotLocation != NSNotFound && range.location > dotLocation+2) {
                NSLog(@"小数点后最多两位");
                return NO;
            }
            
            if (textField.text.length > 11) {
                return NO;
            }
        }
        return YES;
    } else
        return YES;
}


@end
