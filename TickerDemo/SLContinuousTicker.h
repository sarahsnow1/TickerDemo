//
//  SLContinuousTicker.h
//  TickerDemo
//
//  Created by Sarah Lensing on 7/8/12.
//  Copyright (c) 2012 NYU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLDoubleSideTicker.h"

@interface SLContinuousTicker : NSObject<SLDoubleSideTickerDelegate> {
    CGRect _frame;
    UIView *_view;
    
    NSArray *_topTickers;
    NSArray *_bottomTickers;
    
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

@property (nonatomic, assign) CGPoint position;

@end
