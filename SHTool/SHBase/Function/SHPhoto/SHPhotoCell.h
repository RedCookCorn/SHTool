//
//  BasePhotoCell.h
//  BaseFunc
//
//  Created by 四郎 on 17/7/25.
//  Copyright © 2017年 senyuhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHPhotoCell : UICollectionViewCell

@property (nonatomic, copy) void(^selectBlock)(BOOL selected);


- (void)cameraCell;

- (void)updateCell:(UIImage *)img;

- (void)updateCell:(UIImage *)img selected:(BOOL)selected;

- (void)cancelSelect;

@end
