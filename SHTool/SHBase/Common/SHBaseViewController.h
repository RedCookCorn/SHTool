//
//  SHBaseViewController.h
//  SHTool
//
//  Created by 郑浩 on 18/01/2018.
//  Copyright © 2018 郑浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHBaseViewController : UIViewController

- (void)SHBaseLeftBarButtonItemWithTitle:(NSString *)title
                                   block:(void(^)(void))actionBlock;

- (void)SHBaseLeftBarButtonItemWithImage:(NSString *)imageName
                                   block:(void(^)(void))actionBlock;

- (void)SHBaseRightBarButtonItemWithTitle:(NSString *)title
                                    block:(void(^)(void))actionBlock;

- (void)SHBaseRightBarButtonItemWithImage:(NSString *)imageName
                                    block:(void(^)(void))actionBlock;

@end
