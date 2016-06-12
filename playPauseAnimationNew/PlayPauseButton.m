//
//  PlayPauseButton.m
//  playPauseAnimationNew
//
//  Created by Kunal Chelani on 6/12/16.
//  Copyright © 2016 Kunal Chelani. All rights reserved.
//

#import "PlayPauseButton.h"
#import "ProgressView.h"
@interface PlayPauseButton(){
    CAShapeLayer *left;
    CAShapeLayer *right;
    UIBezierPath *pauseLeftPath;
    UIBezierPath *pauseRightPath;
    UIBezierPath *playLeftPath;
    UIBezierPath *playRightPath;
    KButtonState presentState;
    ProgressView *progressView;
}
@end


@implementation PlayPauseButton

-(instancetype) initWithFrame:(CGRect)frame andInititalState:(KButtonState) initialState{
    CGRect newFrame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.width);
    self = [super initWithFrame:newFrame];
    if (self) {
        presentState = initialState;
        [self createLayers];
    }
    return self;
}
-(void) createLayers{
    left = [CAShapeLayer layer];
    left.fillColor = [UIColor whiteColor].CGColor;
    left.strokeColor = [UIColor whiteColor].CGColor;
    left.path=[self getLeftPathForState:presentState];
    [[self layer] addSublayer:left];
    
    right = [CAShapeLayer layer];
    right.fillColor = [UIColor whiteColor].CGColor;
    right.strokeColor = [UIColor whiteColor].CGColor;
    right.path=[self getRightPathForState:presentState];
    [[self layer] addSublayer:right];
    
    progressView = [[ProgressView alloc] init];
}

-(CGPathRef) getLeftPathForState:(KButtonState) state{
    switch (state) {
        case PlayState:
            return [self getPlayLeftPath].CGPath;
            break;
            
        case PauseState:
            return [self getPauseLeftPath].CGPath;
            break;

        case BufferingState:
            return nil;
            break;
            
        default:
            break;
    }
}

-(CGPathRef) getRightPathForState:(KButtonState) state{
    switch (state) {
        case PlayState:
            return [self getPlayRightPath].CGPath;
            break;
            
        case PauseState:
            return [self getPauseRightPath].CGPath;
            break;
            
        case BufferingState:
            return nil;
            break;
            
        default:
            break;
    }
    
}

-(UIBezierPath*) getPauseLeftPath{
    if (!pauseLeftPath) {
        pauseLeftPath = [UIBezierPath bezierPath];
        // Set the starting point of the shape.
        [pauseLeftPath moveToPoint:CGPointMake(0.0, 0.0)];
        [pauseLeftPath addLineToPoint:CGPointMake(self.frame.size.width/3, 0.0)];
        [pauseLeftPath addLineToPoint:CGPointMake(self.frame.size.width/3, self.frame.size.height)];
        [pauseLeftPath addLineToPoint:CGPointMake(0.0, self.frame.size.height)];
        [pauseLeftPath closePath];
    }
    return pauseLeftPath;
}

-(UIBezierPath*) getPauseRightPath{
    if (!pauseRightPath) {
        pauseRightPath = [UIBezierPath bezierPath];
        // Set the starting point of the shape.
        [pauseRightPath moveToPoint:CGPointMake(2*self.frame.size.width/3, 0.0)];
        [pauseRightPath addLineToPoint:CGPointMake(self.frame.size.width, 0.0)];
        [pauseRightPath addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
        [pauseRightPath addLineToPoint:CGPointMake(2*self.frame.size.width/3, self.frame.size.height)];
        [pauseRightPath closePath];
    }
    return pauseRightPath;
}


-(UIBezierPath*) getPlayLeftPath{
    if (!playLeftPath) {
        playLeftPath = [UIBezierPath bezierPath];
        // Set the starting point of the shape.
        [playLeftPath moveToPoint:CGPointMake(0.0, 0.0)];
        [playLeftPath addLineToPoint:CGPointMake(self.frame.size.width/2, self.frame.size.height/4)];
        [playLeftPath addLineToPoint:CGPointMake(self.frame.size.width/2, 3*self.frame.size.height/4)];
        [playLeftPath addLineToPoint:CGPointMake(0.0, self.frame.size.height)];
        [playLeftPath closePath];
    }
    return playLeftPath;
}

-(UIBezierPath*) getPlayRightPath{
    if (!playRightPath) {
        playRightPath = [UIBezierPath bezierPath];
        // Set the starting point of the shape.
        [playRightPath moveToPoint:CGPointMake(self.frame.size.width/2, self.frame.size.height/4)];
        [playRightPath addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height/2)];
        [playRightPath addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height/2)];
        [playRightPath addLineToPoint:CGPointMake(self.frame.size.width/2, 3*self.frame.size.height/4)];
        [playRightPath closePath];
    }
    return playRightPath;
}

-(CABasicAnimation*) getLeftTransfromShapeAnimationForNewState:(KButtonState)newState{
    CABasicAnimation* transfromShapeAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    transfromShapeAnimation.duration = 0.2;
    transfromShapeAnimation.fillMode = kCAFillModeForwards;
    transfromShapeAnimation.removedOnCompletion = false;
    transfromShapeAnimation.fromValue = (__bridge id _Nullable)([self getLeftPathForState:presentState]);
    transfromShapeAnimation.toValue = (__bridge id _Nullable)([self getLeftPathForState:newState]);
    return transfromShapeAnimation;
}
-(CABasicAnimation*) getRightTransfromShapeAnimationForNewState:(KButtonState)newState{
    CABasicAnimation* transfromShapeAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    transfromShapeAnimation.duration = 0.2;
    transfromShapeAnimation.fillMode = kCAFillModeForwards;
    transfromShapeAnimation.removedOnCompletion = false;
    transfromShapeAnimation.fromValue = (__bridge id _Nullable)([self getRightPathForState:presentState]);
    transfromShapeAnimation.toValue = (__bridge id _Nullable)([self getRightPathForState:newState]);
    return transfromShapeAnimation;
}

-(void) setButtonState:(KButtonState) newState{
    if (newState!=presentState) {
        [left addAnimation:[self getLeftTransfromShapeAnimationForNewState:newState] forKey:@"animatePath"];
        [right addAnimation:[self getRightTransfromShapeAnimationForNewState:newState] forKey:@"animatePath"];
        if (newState==BufferingState) {
            left.hidden=YES;
            right.hidden=YES;
            [self showProgressView];
        }
        else if (presentState==BufferingState) {
            [self hideProgressView];
            left.hidden=NO;
            right.hidden=NO;
        }
        presentState = newState;

    }
}

-(void) showProgressView{
    if (!progressView) {
        progressView = [[ProgressView alloc] init];
    }
    if (progressView) {
        //        [self addSubview:progressView];
        [progressView startProgressAnimationOn:self withCenter:CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5) withSize:progressViewLarge];
        [self setUserInteractionEnabled:NO];
    }
}

-(void) hideProgressView{
    if (progressView) {
        //        [progressView removeFromSuperview];
        [progressView removeProgressView];
        [self setUserInteractionEnabled:YES];
    }
}


@end
