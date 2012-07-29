//
//  SLViewController.h
//  TickerDemo
//
//  Created by Sarah Lensing on 7/6/12.
//  Copyright (c) 2012 NYU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLPicker.h"

@class SLDoubleSideTicker;
@class SLContinuousTicker;

@interface SLViewController : UIViewController <SLTickerViewDelegate, SLPickerDataSource> {
    SLPicker *_ticker;    
    SLContinuousTicker *_testTicker;
    SLDoubleSideTicker *_doubleSide;
}

@property (nonatomic, retain) NSArray *topImageViews;
@property (nonatomic, retain) NSArray *bottomImageViews;

@end
