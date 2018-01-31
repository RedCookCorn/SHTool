//
//  SHBaseActionSheet.m
//  SHTool
//
//  Created by 四郎 on 31/01/2018.
//  Copyright © 2018 郑浩. All rights reserved.
//

#import "SHBaseActionSheet.h"
#import "SHBaseManager.h"

@interface CustomActionSheet : UIView {
    UIView *mask;
}

@property (nonatomic, copy) void(^block)(NSInteger tag);

-(instancetype)initWithBlock:(void (^)(NSInteger tag)) block
                       title:(NSString *)title
                  titleColor:(UIColor *)titleColor
           cancelButtonTitle:(NSString *)cancelTitle
                 cancelColor:(UIColor *)cancelColor
      destructiveButtonTitle:(NSString *)destructiveButtonTitle
                       color:(UIColor *)destructiveColor
           otherButtonTitles:(NSArray *)otherButtonTitles
                  otherColor:(UIColor *)otherColor;

-(void)showInView:(UIView *)view;

-(void)dismiss:(id)tag;

@end

@implementation CustomActionSheet

-(instancetype)initWithBlock:(void (^)(NSInteger tag)) block
                       title:(NSString *)title
                  titleColor:(UIColor *)titleColor
           cancelButtonTitle:(NSString *)cancelTitle
                 cancelColor:(UIColor *)cancelColor
      destructiveButtonTitle:(NSString *)destructiveButtonTitle
                       color:(UIColor *)destructiveColor
           otherButtonTitles:(NSArray *)otherButtonTitles
                  otherColor:(UIColor *)otherColor {
    
    if (self = [super init]) {
        self.backgroundColor = [SHBaseManager shareInstance].commonSheetBgColor;
        self.block = block;
        self.frame = CGRectMake(0, 0, [SHBaseManager screenWidth], 100);
        CGFloat top = 0.0f;
        if (title == nil || [title isEqualToString:@""]) {
            top = 0.0f;
        } else {
            top = 48.0f;
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 48)];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            if (titleColor) {
                titleLabel.textColor = titleColor;
            }else {
                titleLabel.textColor = [UIColor lightGrayColor];
            }
            titleLabel.backgroundColor = [UIColor whiteColor];
            titleLabel.text = title;
            titleLabel.font = [UIFont systemFontOfSize:13.0f];
            [self addSubview:titleLabel];
            
            UILabel *line10 = [[UILabel alloc] initWithFrame:CGRectMake(0, top-1, self.frame.size.width, 0.5f)];
            line10.backgroundColor = [SHBaseManager shareInstance].commonSheetSeperatorColor;
            [self addSubview:line10];
        }
        
        NSInteger otherButtonCount = (otherButtonTitles == nil)? 0:otherButtonTitles.count;
        for (int i = 0;i<otherButtonTitles.count;i++) {
            UIButton *otherButton = [UIButton buttonWithType:UIButtonTypeSystem];
            if (destructiveButtonTitle == nil || [destructiveButtonTitle isEqualToString:@""]) {
                otherButton.tag = otherButtonCount - i;
            }else {
                otherButton.tag = otherButtonCount+1 - i;
            }
            [otherButton setFrame:CGRectMake(0, top, [SHBaseManager screenWidth], [SHBaseManager shareInstance].commonSheetButtonHeight)];
            [otherButton setTitle:otherButtonTitles[i] forState:UIControlStateNormal];
            if (otherColor) {
                [otherButton setTitleColor:otherColor forState:UIControlStateNormal];
            }else {
                [otherButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
            [otherButton.titleLabel setFont:[UIFont systemFontOfSize:17.0f]];
            [otherButton setBackgroundColor:[SHBaseManager shareInstance].commonSheetArrayButtonColor];
            [otherButton addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:otherButton];
            top+=[SHBaseManager shareInstance].commonSheetButtonHeight;
            
            UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(0, otherButton.frame.size.height-0.5, [SHBaseManager screenWidth], 0.5)];
            line2.backgroundColor = [SHBaseManager shareInstance].commonSheetSeperatorColor;
            [otherButton addSubview:line2];
        }
        if (destructiveButtonTitle == nil || [destructiveButtonTitle isEqualToString:@""]) {
            
        }else {
            UIButton *destructiveButton = [UIButton buttonWithType:UIButtonTypeSystem];
            destructiveButton.tag = 1;
            [destructiveButton setFrame:CGRectMake(0, top, [SHBaseManager screenWidth], [SHBaseManager shareInstance].commonSheetButtonHeight)];
            if (destructiveColor) {
                [destructiveButton setTitleColor:destructiveColor forState:UIControlStateNormal];
            }else {
                [destructiveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
            [destructiveButton.titleLabel setFont:[UIFont systemFontOfSize:17.0f]];
            [destructiveButton setTitle:destructiveButtonTitle forState:UIControlStateNormal];
            [destructiveButton setBackgroundColor:[UIColor whiteColor]];
            [destructiveButton addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:destructiveButton];
            top+=[SHBaseManager shareInstance].commonSheetButtonHeight;
        }
        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
        cancelButton.tag = 0;
        [cancelButton setFrame:CGRectMake(0, top, [SHBaseManager screenWidth], [SHBaseManager shareInstance].commonSheetButtonHeight)];
        [cancelButton setTitle:cancelTitle forState:UIControlStateNormal];
        if (cancelColor) {
            [cancelButton setTitleColor:cancelColor forState:UIControlStateNormal];
        }else {
            [cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:17.0f]];
        [cancelButton setBackgroundColor:[UIColor whiteColor]];
        [cancelButton addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelButton];
        
        UILabel *line4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [SHBaseManager screenWidth], 0.5)];
        line4.backgroundColor = [SHBaseManager shareInstance].commonSheetSeperatorColor;
        [cancelButton addSubview:line4];
        
        top += [SHBaseManager shareInstance].commonSheetButtonHeight;
        self.frame = CGRectMake(0, 0, [SHBaseManager screenWidth], top);
    }
    return self;
}

-(void)showInView:(UIView *)view {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UIView *backView = [[UIView alloc] initWithFrame:window.bounds];
    backView.tag = NSIntegerMax;
    mask = [[UIView alloc] initWithFrame:backView.bounds];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction)];
    [mask addGestureRecognizer:tapGesture];
    
    self.frame = CGRectMake(0, [SHBaseManager screenHeight]+1, [SHBaseManager screenWidth], self.frame.size.height);
    mask.alpha = 0.0f;
    mask.backgroundColor = [UIColor blackColor];
    [backView addSubview:mask];
    [backView addSubview:self];
    [view.window addSubview:backView];
    [UIView animateWithDuration:0.3f animations:^{
        self.frame = CGRectMake(0, [SHBaseManager screenHeight]-self.frame.size.height, [SHBaseManager screenWidth], self.frame.size.height);
        mask.alpha = 0.6f;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)dismiss:(UIButton *)sender {
    [self hideActionSheet];
    if (self.block) {
        self.block(sender.tag);
        self.block = nil;
    }
}

-(void)tapGestureAction {
    [self hideActionSheet];
}

-(void)hideActionSheet {
    [UIView animateWithDuration:0.3f animations:^{
        self.frame = CGRectMake(0, [SHBaseManager screenHeight]+1, [SHBaseManager screenWidth], self.frame.size.height);
        mask.alpha = 0.0f;
    } completion:^(BOOL finished) {
        UIView *backView = self.superview;
        if (backView.tag == NSIntegerMax) {
            [backView removeFromSuperview];
        }
    }];
}

@end

@implementation SHBaseActionSheet

+ (void)actionSheetConfirm:(void(^)(NSInteger tag)) block
                     title:(NSString *)title
                     color:(UIColor *)titleColor
                    cancel:(NSString *)cancelTitle
                     color:(UIColor *)cancelColor
          destructiveTitle:(NSString *)destructiveTitle
                     color:(UIColor *)destructiveColor
               otherTitles:(NSArray *)otherTitles
                     color:(UIColor *)otherColor
                    inView:(UIView *)viewToShow {
    
    CustomActionSheet *actionSheet = [[CustomActionSheet alloc] initWithBlock:block
                                                                        title:title
                                                                   titleColor:titleColor
                                                            cancelButtonTitle:cancelTitle
                                                                  cancelColor:cancelColor
                                                       destructiveButtonTitle:destructiveTitle
                                                                        color:destructiveColor
                                                            otherButtonTitles:otherTitles
                                                                   otherColor:otherColor];
    [actionSheet showInView:viewToShow];
}

@end
