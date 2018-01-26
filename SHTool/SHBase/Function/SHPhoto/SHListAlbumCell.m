//
//  ListAlbumCell.m
//  BaseFunc
//
//  Created by 四郎 on 2017/7/27.
//  Copyright © 2017年 senyuhao. All rights reserved.
//

#import "SHListAlbumCell.h"

@interface SHListAlbumCell()

@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;
@property (weak, nonatomic) IBOutlet UILabel *lbText;
@property (weak, nonatomic) IBOutlet UILabel *lbCount;


@end

@implementation SHListAlbumCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)updateCell:(SHBaseAlbum *)base {
    self.imgIcon.image = base.image;
    self.lbText.text = base.text;
    if (base.imageCount > 0) {
        self.lbCount.text = [NSString stringWithFormat:@"(%d)",(int)base.imageCount];
    } else {
        self.lbCount.text = @"";
    }
}

@end
