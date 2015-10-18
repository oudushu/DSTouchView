//
//  ViewController.m
//  DSDraggablePad
//
//  Created by 欧杜书 on 15/10/16.
//  Copyright © 2015年 DuShu. All rights reserved.
//

#import "ViewController.h"
#import "DSTouchView.h"

@interface ViewController () <DSTouchViewDelegate>
@property (nonatomic, strong) DSTouchView *touchView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(35, 270, 200, 21)];
    label.text = @"Init with code:";
    [self.view addSubview:label];
    
    DSTouchView *touchView = [[DSTouchView alloc] initWithFrame:CGRectMake(35,  300, 70, 120)];
    touchView.maxValue = 50.0f;
    touchView.minValue = 0.0f;
    touchView.initialValue = 25.0f;
    touchView.isValueCanCirculate = YES;
    [touchView addTarget:self action:@selector(touchViewValueChanged) forControlEvents:UIControlEventValueChanged];
    touchView.delegate = self;
    [self.view addSubview:touchView];
    self.touchView = touchView;
}

#pragma mark - touchViewControlEvents
- (void)touchViewValueChanged {
    NSLog(@"~~~~~~~~~~~~touchViewCurrentValue:%f", self.touchView.currentValue);
}

#pragma mark - touchView delegate
- (void)touchViewBeginTouchWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    NSLog(@"~~~~~touchViewBeginTouchWithTouch~~~~~");
}

- (void)touchViewContinueTouchWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    NSLog(@"~~~~~touchViewContinueTouchWithTouch~~~~~");
}

- (void)touchViewDidEndTouchWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    NSLog(@"~~~~~touchViewDidEndTouchWithTouch~~~~~");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
