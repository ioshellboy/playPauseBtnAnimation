//
//  ProgressView.m
//  Gaana
//
//  Created by Kunal Chelani on 2/16/16.
//  Copyright © 2016 TimesInternet. All rights reserved.
//

#import "ProgressView.h"
@interface ProgressView()
{
    CAShapeLayer *_indefiniteAnimatedLayer;
}
@end


@implementation ProgressView

-(void) startProgressAnimationOn:(UIView*)parentView withCenter:(CGPoint)center withSize:(ProgressViewSize) sizeType{
    if (parentView) {
        CAShapeLayer *progress = [self getIndefiniteAnimatedLayerWithCenter:center withSize:sizeType];
//        [parentView.layer insertSublayer:progress atIndex:[parentView.layer.sublayers count]];
        [parentView.layer addSublayer:progress];
    }
}
-(void) removeProgressView{
    if (_indefiniteAnimatedLayer) {
        [_indefiniteAnimatedLayer removeFromSuperlayer];
    }
}



- (CAShapeLayer*)getIndefiniteAnimatedLayerWithCenter:(CGPoint)circleCenter withSize:(ProgressViewSize) sizeType{
    if(!_indefiniteAnimatedLayer) {
        
        NSInteger radius=sizeType;
        NSInteger strokeThickness=4.0f;
        if (sizeType==progressViewSmall) {
            strokeThickness=2.0f;
        }
        
        
        CGPoint arcCenter = circleCenter;
        CGRect rect = CGRectMake(0.0f, 0.0f, arcCenter.x*2, arcCenter.y*2);
        
        UIBezierPath* smoothedPath = [UIBezierPath bezierPathWithArcCenter:arcCenter
                                                                    radius:radius
                                                                startAngle:M_PI*3/2
                                                                  endAngle:M_PI/2+M_PI*5
                                                                 clockwise:YES];
        
    _indefiniteAnimatedLayer = [CAShapeLayer layer];
    _indefiniteAnimatedLayer.contentsScale = [[UIScreen mainScreen] scale];
    _indefiniteAnimatedLayer.frame = rect;
    _indefiniteAnimatedLayer.fillColor = [UIColor clearColor].CGColor;
    _indefiniteAnimatedLayer.strokeColor = [UIColor whiteColor].CGColor;
    _indefiniteAnimatedLayer.lineWidth = strokeThickness;
    _indefiniteAnimatedLayer.lineCap = kCALineCapRound;
    _indefiniteAnimatedLayer.lineJoin = kCALineJoinBevel;
    _indefiniteAnimatedLayer.path = smoothedPath.CGPath;
    
    CALayer *maskLayer = [CALayer layer];
    
    maskLayer.contents = (id)[[UIImage imageNamed:@"angle-mask"] CGImage];;
    
    maskLayer.frame = _indefiniteAnimatedLayer.bounds;
    _indefiniteAnimatedLayer.mask = maskLayer;
    
    NSTimeInterval animationDuration = 1;
    CAMediaTimingFunction *linearCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.fromValue = 0;
    animation.toValue = [NSNumber numberWithFloat:M_PI*2];
    animation.duration = animationDuration;
    animation.timingFunction = linearCurve;
    animation.removedOnCompletion = NO;
    animation.repeatCount = INFINITY;
    animation.fillMode = kCAFillModeForwards;
    animation.autoreverses = NO;
    [_indefiniteAnimatedLayer.mask addAnimation:animation forKey:@"rotate"];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = animationDuration;
    animationGroup.repeatCount = INFINITY;
    animationGroup.removedOnCompletion = NO;
    animationGroup.timingFunction = linearCurve;
    
    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.fromValue = @0.015;
    strokeStartAnimation.toValue = @0.515;
    
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue = @0.485;
    strokeEndAnimation.toValue = @0.985;
    
    animationGroup.animations = @[strokeStartAnimation, strokeEndAnimation];
    [_indefiniteAnimatedLayer addAnimation:animationGroup forKey:@"progress"];
    
        }
    return _indefiniteAnimatedLayer;
}


@end
