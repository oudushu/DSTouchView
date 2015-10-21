//
//  DSTouchView.m
//  
//
//  Created by DuShu on 15/9/11.
//  Copyright (c) 2015年 DuShu. All rights reserved.
//

#import "DSTouchView.h"
#include <Availability.h>
#define ButtonH 20

@interface DSTouchView()
@property (nonatomic, weak) UIButton *topButton;
@property (nonatomic, weak) UIButton *bottomButton;
@property (nonatomic, assign) CGPoint lastPoint;
@property (nonatomic, assign) BOOL isSliding;
@end

@implementation DSTouchView

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        UIButton *topButton = [[UIButton alloc] init];
        [self addSubview:topButton];
        self.topButton = topButton;
        
        UIButton *bottomButton = [[UIButton alloc] init];
        [self addSubview:bottomButton];
        self.bottomButton = bottomButton;
        
        UILabel *valueLabel = [[UILabel alloc] init];
        [self addSubview:valueLabel];
        self.valueLabel = valueLabel;
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        self.imageView = imageView;
        self.enabledTracking = YES;
        self.isValueCanCirculate = NO;
        self.maxValue = 100.0f;
        self.minValue = 0.0f;
        self.initialValue = 50.0f;
        self.currentValue = self.initialValue;
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        UIButton *topButton = [[UIButton alloc] init];
        [self addSubview:topButton];
        self.topButton = topButton;
        
        UIButton *bottomButton = [[UIButton alloc] init];
        [self addSubview:bottomButton];
        self.bottomButton = bottomButton;
        
        UILabel *valueLabel = [[UILabel alloc] init];
        [self addSubview:valueLabel];
        self.valueLabel = valueLabel;
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        self.imageView = imageView;
        self.enabledTracking = YES;
        self.isValueCanCirculate = NO;
        self.maxValue = 100.0f;
        self.minValue = 0.0f;
        self.initialValue = 50.0f;
        self.currentValue = self.initialValue;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *topButton = [[UIButton alloc] init];
        [self addSubview:topButton];
        self.topButton = topButton;
        
        UIButton *bottomButton = [[UIButton alloc] init];
        [self addSubview:bottomButton];
        self.bottomButton = bottomButton;
        
        UILabel *valueLabel = [[UILabel alloc] init];
        [self addSubview:valueLabel];
        self.valueLabel = valueLabel;
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        self.imageView = imageView;
        self.enabledTracking = YES;
        self.isValueCanCirculate = NO;
        self.maxValue = 100.0f;
        self.minValue = 0.0f;
        self.initialValue = 50.0f;
        self.currentValue = self.initialValue;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat buttonW = self.frame.size.width;
    CGFloat labelH = self.frame.size.height - ButtonH * 2;
    
    self.topButton.frame = CGRectMake(0, 0, buttonW, ButtonH);
    self.topButton.showsTouchWhenHighlighted = YES;
    self.topButton.backgroundColor = [UIColor clearColor];
    [self.topButton setTitle:@"+" forState:UIControlStateNormal];
    self.topButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.topButton.contentEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
    [self.topButton addTarget:self action:@selector(topButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.bottomButton.frame = CGRectMake(0, ButtonH + labelH, buttonW, ButtonH);
    self.bottomButton.showsTouchWhenHighlighted = YES;
    self.bottomButton.backgroundColor = [UIColor clearColor];
    [self.bottomButton setTitle:@"-" forState:UIControlStateNormal];
    self.bottomButton.contentEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
    self.bottomButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.bottomButton addTarget:self action:@selector(bottomButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.valueLabel.frame = CGRectMake(0, ButtonH, buttonW, labelH);
    self.valueLabel.text = self.valueLabelText;
    self.valueLabel.textAlignment = NSTextAlignmentCenter;
    self.valueLabel.textColor = [UIColor whiteColor];
    self.valueLabel.font = [UIFont systemFontOfSize:35];
    if (!self.valueLabelText) {
        self.valueLabel.text = [NSString stringWithFormat:@"%.f", self.currentValue];
    }
    if (self.imageView.image) {
        self.imageView.frame = CGRectMake(0, 0, buttonW - 10, 30);
        self.imageView.center = self.valueLabel.center;
        
        self.imageView.userInteractionEnabled = NO;
        [self.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
}

- (void)topButtonClick {
    [self dealWithChangedValue:1];
}

- (void)bottomButtonClick {
    [self dealWithChangedValue:-1];
}

#pragma mark - events
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super beginTrackingWithTouch:touch withEvent:event];
    CGPoint beginPoint = [touch locationInView:self.superview];
    self.lastPoint = beginPoint;
    self.isSliding = NO;
    if ([self.delegate respondsToSelector:@selector(touchViewBeginTouchWithTouch:withEvent:)]) {
        [self.delegate touchViewBeginTouchWithTouch:touch withEvent:event];
    }
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super continueTrackingWithTouch:touch withEvent:event];
    self.isSliding = YES;
    CGPoint currentPoint = [touch locationInView:self.superview];
    CGFloat changedValue = - (currentPoint.y - self.lastPoint.y);
    
    // 判断差值, 如果差值太小, 值变化速率会太快
    if (self.maxValue - self.minValue > 100) {
        [self dealWithChangedValue:changedValue / 4];
    } else if (self.maxValue - self.minValue <= 10) {
        [self dealWithChangedValue:changedValue / 45];
    } else {
        [self dealWithChangedValue:changedValue / 10];
    }
    self.lastPoint = currentPoint;
    
    if ([self.delegate respondsToSelector:@selector(touchViewContinueTouchWithTouch:withEvent:)]) {
        [self.delegate touchViewContinueTouchWithTouch:touch withEvent:event];
    }
    return self.enabledTracking;
}


- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super endTrackingWithTouch:touch withEvent:event];
    
    if ([self.delegate respondsToSelector:@selector(touchViewDidEndTouchWithTouch:withEvent:)]) {
        [self.delegate touchViewDidEndTouchWithTouch:touch withEvent:event];
    }
}

- (void)cancelTrackingWithEvent:(UIEvent *)event {
    [super cancelTrackingWithEvent:event];
}

- (void)dealWithChangedValue:(CGFloat)changedValue {
    if (self.currentValue <= self.maxValue && self.currentValue >= self.minValue) {
        self.currentValue += changedValue;
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
    if (!self.valueLabelText) {
        self.valueLabel.text = [NSString stringWithFormat:@"%.f", self.currentValue];
    }
}

#pragma mark - getters & setters
- (CGFloat)currentValue {
    if (_currentValue > self.maxValue) {
        return self.isValueCanCirculate ? self.minValue : self.maxValue;
    } else if (_currentValue < self.minValue) {
        return self.isValueCanCirculate ? self.maxValue : self.minValue;
    } else {
        return _currentValue;
    }
}

- (void)setInitialValue:(CGFloat)initialValue {
    if (_initialValue != initialValue) {
        _initialValue = initialValue;
    }
    self.currentValue = initialValue;
}

@end
