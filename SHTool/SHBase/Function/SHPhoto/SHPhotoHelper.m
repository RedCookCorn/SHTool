//
//  SHPhotoHelper.m
//  SHTool
//
//  Created by senyuhao on 26/01/2018.
//  Copyright © 2018 郑浩. All rights reserved.
//

#import "SHPhotoHelper.h"
#import "SHPhotoVC.h"

@implementation SHPhotoHelper

+ (void)presentFrom:(UIViewController *)vc selectPhotoResult:(void(^)(NSArray *imageArray))resultBlock {
    SHPhotoVC *photovc = [SHPhotoVC new];
    photovc.maxSelect = 3;
    photovc.imageDataBlock = ^(NSArray *imageDataArr) {
        if (resultBlock) {
            resultBlock(imageDataArr);
        }
    };
    [vc presentViewController:[[UINavigationController alloc] initWithRootViewController:photovc] animated:YES completion:nil];
}

+ (void)navigationFrom:(UIViewController *)vc selectPhotoResult:(void(^)(NSArray *imageArray))resultBlock {
    SHPhotoVC *photovc = [SHPhotoVC new];
    photovc.maxSelect = 3;
    photovc.imageDataBlock = ^(NSArray *imageDataArr) {
        if (resultBlock) {
            resultBlock(imageDataArr);
        }
    };
    [vc.navigationController pushViewController:photovc animated:YES];
}

@end
