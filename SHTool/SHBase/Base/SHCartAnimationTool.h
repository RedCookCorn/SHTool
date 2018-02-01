//
//  SHCartAnimationTool.h
//  SHTool
//
//  Created by senyuhao on 01/02/2018.
//  Copyright © 2018 郑浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SHCartAnimationTool : NSObject

+ (void)addCartAnimationImage:(UIImage *)goodsImage
                   startPoint:(CGPoint)start
                     endPoint:(CGPoint)end
                   completion:(void(^)(BOOL finished))completion;

@end
