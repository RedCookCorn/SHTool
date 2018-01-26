//
//  BaseAlbum.h
//  BaseFunc
//
//  Created by 四郎 on 2017/7/27.
//  Copyright © 2017年 senyuhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHBaseAlbum : NSObject

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) NSInteger imageCount;
@property (nonatomic, copy) NSString *imageurl;

@end
