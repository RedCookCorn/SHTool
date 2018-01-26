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

+ (void)presentFrom:(UIViewController *)vc selectPhotoResult:(void(^)(UIImage *image))resultBlock {
    SHPhotoVC *photovc = [SHPhotoVC new];
    
    [vc presentViewController:[[UINavigationController alloc] initWithRootViewController:photovc] animated:YES completion:nil];
}

+ (void)navigationFrom:(UIViewController *)vc selectPhotoResult:(void(^)(UIImage *image))resultBlock {
    SHPhotoVC *photovc = [SHPhotoVC new];
    
    [vc.navigationController pushViewController:photovc animated:YES];
}

@end
