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
}

- (void)cameraCell {
    _bnSelect.hidden = YES;
    _imgIcon.image = [UIImage imageNamed:@"camera"];
}

- (void)updateCell:(UIImage *)img {
    _bnSelect.hidden = NO;
    _imgIcon.image = img;
}

- (void)updateCell:(UIImage *)img selected:(BOOL)selected {
    _bnSelect.hidden = NO;
    _imgIcon.image = img;
    _bnSelect.selected = selected;
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
