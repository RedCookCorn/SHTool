//
//  SHBaseAlert.m
//  SHTool
//
//  Created by senyuhao on 19/01/2018.
//  Copyright © 2018 郑浩. All rights reserved.
//

#import "SHBaseAlert.h"
#import <UIKit/UIKit.h>
#import "UIColor+SHExtension.h"

@interface CustomAlertView : UIView

@property (nonatomic, copy) void(^block)(NSUInteger answer);

-(id)initWithBlock:(void(^)(NSUInteger answer))block
             title:(NSString *)title
           content:(NSString *)content
            cancel:(NSString *)cancelTitle
           buttons:(NSArray *)buttons;

-(void)show;
-(void)hide:(id)sender;

@end

@implementation CustomAlertView

- (instancetype)initWithBlock:(void (^)(NSUInteger))block
                        title:(NSString *)title
                      content:(NSString *)content
                       cancel:(NSString *)cancelTitle
                      buttons:(NSArray *)buttons {
    if (self = [super init]) {
        self.layer.cornerRadius = 5.0f;
        self.clipsToBounds = YES;
        self.block = block;
        self.frame = CGRectMake(0, 0, 280, 120);
        
        UIImageView *background = [[UIImageView alloc] initWithImage:nil];
        background.backgroundColor = [UIColor colorWithHexs:0xf2f2f2];
        background.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        CGRect frame = self.frame;
        background.frame = frame;
        [self addSubview:background];
        
        CGFloat height = 0;
        if (title && title.length > 0) {
            //标题
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, frame.size.width, 30)];
            titleLabel.text = title;
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
            titleLabel.textColor = [UIColor blackColor];
            titleLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
            [self addSubview:titleLabel];
            height = 45;
        } else {
            height = 20;
        }
        
        frame = background.frame;
        //提示信息
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.text = content;
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = [UIFont systemFontOfSize:16.0f];
        textLabel.textColor = [UIColor colorWithHexs:0x1a1a1a];
        textLabel.numberOfLines = 0;
        CGSize size = [textLabel sizeThatFits:CGSizeMake(frame.size.width - 30, 0)];
        textLabel.frame = CGRectMake(frame.origin.x + 15, height, frame.size.width-30, size.height);
        [self addSubview:textLabel];
        
        UILabel *bottomLine = [[UILabel alloc] initWithFrame:CGRectMake(0, textLabel.frame.origin.y+textLabel.frame.size.height +20, frame.size.width, 0.5f)];
        bottomLine.backgroundColor = [UIColor colorWithHexs:0xcccccc];
        [self addSubview:bottomLine];
        
        CGFloat top = textLabel.frame.origin.y + textLabel.frame.size.height + 20 +5;
        NSUInteger buttonCount = (cancelTitle == nil ? 0 : 1) + buttons.count;
        CGFloat width = background.frame.size.width - 20;
        CGFloat x = background.frame.origin.x +10;
        CGFloat space = 10;
        CGSize btnSize = CGSizeMake((width + space)/buttonCount - space, 35);
        if (buttonCount>1) {
            UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2, bottomLine.frame.origin.y, 0.5f, 100)];
            line.backgroundColor = [UIColor colorWithHexs:0xcccccc];
            [self addSubview:line];
        }
        //按钮
        if (cancelTitle) {
            UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            cancelButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
            if (buttonCount == 1) {
                [cancelButton setTitleColor:[UIColor colorWithHexs:0x000000] forState:UIControlStateNormal];
            }else {
                [cancelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            }
            [cancelButton setTitle:cancelTitle forState:UIControlStateNormal];
            cancelButton.tag = 0;
            [cancelButton addTarget:self action:@selector(hide:) forControlEvents:UIControlEventTouchUpInside];
            cancelButton.frame = CGRectMake(x, top, btnSize.width, btnSize.height);
            [self addSubview:cancelButton];
            x+=space+btnSize.width;
        }
        for (int i = 0; i < buttons.count; i++) {
            UIButton *otherButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            otherButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
            [otherButton setTitleColor:[UIColor colorWithHexs:0x000000] forState:UIControlStateNormal];
            [otherButton setTitle:buttons[i] forState:UIControlStateNormal];
            otherButton.tag = i + 1;
            [otherButton addTarget:self action:@selector(hide:) forControlEvents:UIControlEventTouchUpInside];
            otherButton.frame = CGRectMake(x, top, btnSize.width, btnSize.height);
            [self addSubview:otherButton];
            x+=space+btnSize.width;
        }
        frame = self.frame;
        frame.size.height = top + btnSize.height+5;
        self.frame = frame;
    }
    return self;
}

- (void)show{
    //显示到window
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect frame = CGRectMake((window.bounds.size.width - self.frame.size.width) / 2, (window.bounds.size.height - self.frame.size.height) / 2 - 50, self.frame.size.width, self.frame.size.height);
    self.frame = frame;
    
    UIView *container = [[UIView alloc] initWithFrame:window.bounds];
    container.tag = NSIntegerMax;
    UIView *mask = [[UIView alloc] initWithFrame:container.bounds];
    mask.backgroundColor = [UIColor blackColor];
    mask.alpha = 0.6;
    
    [container addSubview:mask];
    [container addSubview:self];
    [window addSubview:container];
    
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.6f;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.layer addAnimation:popAnimation forKey:nil];
}

- (void)hide:(id)sender {
    if (self.block) {
        self.block([(UIButton *)sender tag]);
        self.block = nil;
    }
    [self dismiss];
}

- (void)dismiss {
    UIView *container = self.superview;
    [UIView animateWithDuration:0.5f animations:^{
        self.alpha = 0.0f;
        container.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (container.tag == NSIntegerMax) {
            [container removeFromSuperview];
        }
    }];
}

@end

@implementation SHBaseAlert

+ (void)alertAsk:(void(^)(NSUInteger answer))block
           title:(NSString *)title
         content:(NSString *)content
          cancle:(NSString *)cancelTitle
         buttons:(NSArray *)buttons {
    CustomAlertView *alertView = [[CustomAlertView alloc] initWithBlock:block
                                                                  title:title
                                                                content:content
                                                                 cancel:cancelTitle
                                                                buttons:buttons];
    [alertView show];
}

+ (void)alertConfirm:(void(^)(void))block
               title:(NSString *)alertTitle
              cancel:(NSString *)cancelTitle
                sure:(NSString *)sureTitle
             content:(id)formatstring,... {
    va_list arglist;
    va_start(arglist, formatstring);
    id statement = [[NSString alloc] initWithFormat:formatstring arguments:arglist];
    va_end(arglist);
    [self alertAsk: ^(NSUInteger a){if(block && a == 1)block();}
             title:sureTitle
           content:statement
            cancle:cancelTitle
           buttons:(sureTitle ==nil)? nil:[NSArray arrayWithObject:sureTitle]];
}

+ (void)alertActions:(void(^)(NSUInteger answer))block
               title:(NSString *)alertTitle
              cancel:(NSString *)cancelTitle
                sure:(NSString *)sureTitle
             content:(id)formatstring,... {
    va_list arglist;
    va_start(arglist, formatstring);
    id statement = [[NSString alloc] initWithFormat:formatstring arguments:arglist];
    va_end(arglist);
    [self alertAsk: ^(NSUInteger a){if(block) block(a);}
             title:sureTitle
           content:statement
            cancle:cancelTitle
           buttons:(sureTitle ==nil)? nil:[NSArray arrayWithObject:sureTitle]];
    
}

@end
