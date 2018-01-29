//
//  SHBaseViewController.m
//  SHTool
//
//  Created by 郑浩 on 18/01/2018.
//  Copyright © 2018 郑浩. All rights reserved.
//

#import "SHBaseViewController.h"
#import <objc/runtime.h>

static char barItemBlock;

@interface SHBaseViewController ()

@end

@implementation SHBaseViewController

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(viewDidLoad);
        SEL swizzledSelector = @selector(custome_viewDidLoad);
        
        Method orignalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(orignalMethod), method_getTypeEncoding(orignalMethod));
        } else {
            method_exchangeImplementations(orignalMethod, swizzledMethod);
        }
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    tapGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGesture];
}

// dismiss responder when tap
- (void)tapAction:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}

// item action
- (void)SHBaseLeftBarButtonItemWithTitle:(NSString *)title
                                   block:(void(^)(void))actionBlock {
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:title
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(itemAction:)];
    objc_setAssociatedObject(leftItem, &barItemBlock, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)SHBaseLeftBarButtonItemWithImage:(NSString *)imageName
                                   block:(void(^)(void))actionBlock {
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:imageName]
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(itemAction:)];
    objc_setAssociatedObject(leftItem, &barItemBlock, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.navigationItem.leftBarButtonItem = leftItem;
    
}

- (void)SHBaseRightBarButtonItemWithTitle:(NSString *)title
                                    block:(void(^)(void))actionBlock {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:title
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(itemAction:)];
    objc_setAssociatedObject(rightItem, &barItemBlock, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)SHBaseRightBarButtonItemWithImage:(NSString *)imageName
                                    block:(void(^)(void))actionBlock {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:imageName]
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(itemAction:)];
    objc_setAssociatedObject(rightItem, &barItemBlock, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)itemAction:(id)sender {
    void(^actionBlock)(void) = objc_getAssociatedObject(sender, &barItemBlock);
    actionBlock();
}

// set no text in backitem
- (void)custome_viewDidLoad {
    [self custome_viewDidLoad];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:nil
                                                                      action:nil];
    backButtonItem.tintColor = [UIColor whiteColor];
    [self.navigationItem setBackBarButtonItem:backButtonItem];
}

@end
