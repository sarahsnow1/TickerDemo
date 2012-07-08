//
//  SLContinuousTicker.h
//  TickerDemo
//
//  Created by Sarah Lensing on 7/8/12.
//  Copyright (c) 2012 NYU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLDoubleSideTicker.h"

@class SLContinuousTicker;
@protocol SLContinuousTickerDelegate <NSObject>
-(void)ticker:(SLContinuousTicker *)ticker didUpdateRotationTransform:(CGFloat)y;
@end

@interface SLContinuousTicker : NSObject<SLDoubleSideTickerDelegate> {
    CGRect _frame;
    UIView *_view;
    
    SLDoubleSideTicker *_tickerA;
    SLDoubleSideTicker *_tickerB;
    SLDoubleSideTicker *_tickerC;   
    SLDoubleSideTicker *_tickerD;
    
    SLDoubleSideTicker *_tickerW;
    SLDoubleSideTicker *_tickerX;
    SLDoubleSideTicker *_tickerY;
    SLDoubleSideTicker *_tickerZ;   
    
    SLDoubleSideTicker *_keyTopTicker;
    SLDoubleSideTicker *_keyBottomTicker;    
}

- (id)initWithFrame:(CGRect)frame superView:(UIView *)superview;

@property (nonatomic, assign) id<SLContinuousTickerDelegate>delegate;
@property (nonatomic, assign) CGPoint position;

@end
