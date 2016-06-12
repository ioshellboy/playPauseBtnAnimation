//
//  PlayPauseButton.h
//  playPauseAnimationNew
//
//  Created by Kunal Chelani on 6/12/16.
//  Copyright © 2016 Kunal Chelani. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    PlayState,
    PauseState,
    BufferingState
}KButtonState;

@interface PlayPauseButton : UIButton
-(instancetype) initWithFrame:(CGRect)frame andInititalState:(KButtonState) initialState;
-(void) setButtonState:(KButtonState) newState;
@end
