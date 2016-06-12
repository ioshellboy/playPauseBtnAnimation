//
//  ProgressView.h
//  Gaana
//
//  Created by Kunal Chelani on 2/16/16.
//  Copyright © 2016 TimesInternet. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    progressViewSmall=10,
    progressViewLarge=18,
} ProgressViewSize;

@interface ProgressView : UIView

-(void) startProgressAnimationOn:(UIView*)parentView withCenter:(CGPoint)center withSize:(ProgressViewSize) sizeType;
-(void) removeProgressView;

@end
