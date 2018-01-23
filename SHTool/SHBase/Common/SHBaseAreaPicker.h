//
//  SHBaseAreaPicker.h
//  SHTool
//
//  Created by senyuhao on 22/01/2018.
//  Copyright © 2018 郑浩. All rights reserved.
//

#import "SHBasePicker.h"

@interface SHBaseAreaPicker : SHBasePicker

- (instancetype)initWithFrame:(CGRect)frame
                  selectBlock:(void(^)(id sender))selectBlock;


@end
