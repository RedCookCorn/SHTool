//
//  BasePhotoCell.m
//  BaseFunc
//
//  Created by 四郎 on 17/7/25.
//  Copyright © 2017年 senyuhao. All rights reserved.
//

#import "SHPhotoCell.h"

@interface SHPhotoCell()

@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;
@property (weak, nonatomic) IBOutlet UIButton *bnSelect;

@end

@implementation SHPhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor blackColor];
}

- (void)cameraCell {
    _bnSelect.hidden = YES;
    _imgIcon.image = [UIImage imageNamed:@"sh_image_camera"];
    _imgIcon.contentMode = UIViewContentModeCenter;
}

- (void)updateCell:(UIImage *)img {
    _bnSelect.hidden = NO;
    _imgIcon.image = img;
    _imgIcon.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)updateCell:(UIImage *)img selected:(BOOL)selected {
    _bnSelect.hidden = NO;
    _imgIcon.image = img;
    _bnSelect.selected = selected;
    _imgIcon.contentMode = UIViewContentModeScaleAspectFill;
}

// 选择操作
- (IBAction)selectAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (self.selectBlock) {
        self.selectBlock(sender.selected);
    }
}

- (void)cancelSelect {
    _bnSelect.selected = NO;
}
@end
