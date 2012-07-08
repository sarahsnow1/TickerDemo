//
//  SLViewController.h
//  TickerDemo
//
//  Created by Sarah Lensing on 7/6/12.
//  Copyright (c) 2012 NYU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLContinuousTicker.h"

@interface SLViewController : UIViewController <SLContinuousTickerDelegate, SLTickerViewDelegate> {
    SLContinuousTicker *_ticker;    
    SLTickerView *_testTicker;
}

@end
