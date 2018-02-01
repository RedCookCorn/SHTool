//
//  SHCartAnimationTool.m
//  SHTool
//
//  Created by senyuhao on 01/02/2018.
//  Copyright © 2018 郑浩. All rights reserved.
//

#import "SHCartAnimationTool.h"

@implementation SHCartAnimationTool

+ (void)addCartAnimationImage:(UIImage *)goodsImage
                   startPoint:(CGPoint)start
                     endPoint:(CGPoint)end
                   completion:(void(^)(BOOL finished))completion {
    
    CGSize size = goodsImage.size;
    CAShapeLayer *animationLayer = [[CAShapeLayer alloc] init];
    animationLayer.frame = CGRectMake(start.x - size.width/2, start.y - size.height/2, size.width, size.height);
    animationLayer.contents = (id)goodsImage.CGImage;
    
    // 添加layer到顶层视图控制器上
    UIViewController *rootVC = [[UIApplication sharedApplication].delegate window].rootViewController;
    UIViewController *parentVC = rootVC;
    while ((parentVC = rootVC.presentedViewController) != nil ) {
        rootVC = parentVC;
    }
    while ([rootVC isKindOfClass:[UINavigationController class]]) {
        rootVC = [(UINavigationController *)rootVC topViewController];
    }
    [rootVC.view.layer addSublayer:animationLayer];
    
    // 创建移动轨迹
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:start];
    [movePath addQuadCurveToPoint:end controlPoint:CGPointMake(end.x, start.y)];
    
    // 轨迹动画
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGFloat durationTime = 1; // 动画时间1秒
    pathAnimation.duration = durationTime;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.path = movePath.CGPath;
    [animationLayer addAnimation:pathAnimation forKey:nil];
    
    // 缩小动画
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:0.5];
    scaleAnimation.duration = 1.0;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fillMode = kCAFillModeForwards;
    [animationLayer addAnimation:scaleAnimation forKey:nil];
    
    // 旋转动画
    CABasicAnimation *circleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    circleAnimation.fromValue = [NSNumber numberWithFloat:0.f];
    circleAnimation.toValue = [NSNumber numberWithFloat:M_PI *2];
    circleAnimation.duration = 0.4;
    circleAnimation.autoreverses = NO;
    circleAnimation.fillMode = kCAFillModeForwards;
    circleAnimation.repeatCount = MAXFLOAT;
    [animationLayer addAnimation:circleAnimation forKey:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(durationTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [animationLayer removeFromSuperlayer];
        completion(YES);
    });
}

@end
