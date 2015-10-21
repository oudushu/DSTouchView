//
//  DSTouchView.h
//
//
//  Created by DuShu on 15/9/11.
//  Copyright (c) 2015年 DuShu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@class DSTouchView;

@protocol DSTouchViewDelegate <NSObject>
@optional
- (void)touchViewBeginTouchWithTouch:(UITouch *)touch withEvent:(UIEvent *)event;
- (void)touchViewContinueTouchWithTouch:(UITouch *)touch withEvent:(UIEvent *)event;
- (void)touchViewDidEndTouchWithTouch:(UITouch *)touch withEvent:(UIEvent *)event;
@end

@interface DSTouchView : UIControl
@property (nonatomic, assign) CGFloat maxValue; // default is 100.
@property (nonatomic, assign) CGFloat minValue; //default is 0.
@property (nonatomic, assign) CGFloat initialValue; //default is 50.
@property (nonatomic, assign) CGFloat currentValue;

@property (nonatomic, assign) BOOL enabledTracking; //default is yes.
@property (nonatomic, assign) BOOL isValueCanCirculate; // default is NO

@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, copy) NSString *valueLabelText;
@property (nonatomic, weak) UIImageView *imageView;

@property (nonatomic, weak) id <DSTouchViewDelegate> delegate;
@end
