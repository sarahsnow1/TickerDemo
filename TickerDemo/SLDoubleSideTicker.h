//
//  SLDoubleSideTickerView.h
//  TickerDemo
//
//  Created by Sarah Lensing on 7/8/12.
//  Copyright (c) 2012 NYU. All rights reserved.
//

#import "SLTickerView.h"

@class SLDoubleSideTicker;
@protocol SLDoubleSideTickerDelegate <NSObject>
-(void)ticker:(SLDoubleSideTicker *)ticker didUpdateRotationTransform:(CGFloat)y;
@end

@interface SLDoubleSideTicker : NSObject <SLTickerViewDelegate> {
    CGRect _frame;
    UIView *_view;
    SLTickerView *_frontTicker;
    SLTickerView *_backTicker;
}

@property (nonatomic, assign) id<SLDoubleSideTickerDelegate>delegate;
@property (nonatomic, assign) TickerViewAnchorType anchorType;
@property (nonatomic, assign) TickerViewFlipSpeed flipSpeed;
@property (nonatomic, assign) CGPoint position;
@property (nonatomic, assign) UIColor *backBackgroundColor;
@property (nonatomic, assign) UIColor *frontBackgroundColor;
@property (nonatomic, assign) UIView *backView;
@property (nonatomic, assign) UIView *frontView;

- (id)initWithFrame:(CGRect)frame superView:(UIView *)superview;
- (void)bringToFront;
- (void)updateRotationTransform:(CGFloat)y;

@end
