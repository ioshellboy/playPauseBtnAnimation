//
//  ViewController.m
//  playPauseAnimationNew
//
//  Created by Kunal Chelani on 6/12/16.
//  Copyright © 2016 Kunal Chelani. All rights reserved.
//

#import "ViewController.h"
#import "PlayPauseButton.h"
#import "ProgressView.h"
@interface ViewController ()
{
    PlayPauseButton *playPauseBtn;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    playPauseBtn= [[PlayPauseButton alloc] initWithFrame:CGRectMake(100, 100, 50, 50) andInititalState:PauseState];
    [self.view addSubview:playPauseBtn];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)playBtn:(id)sender {
    [playPauseBtn setButtonState:PlayState];
}
- (IBAction)pauseBtn:(id)sender {
    [playPauseBtn setButtonState:PauseState];
}
- (IBAction)bufferingBtn:(id)sender {
    [playPauseBtn setButtonState:BufferingState];
}

@end
