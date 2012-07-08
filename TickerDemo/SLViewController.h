//
//  SLViewController.h
//  TickerDemo
//
//  Created by Sarah Lensing on 7/6/12.
//  Copyright (c) 2012 NYU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLDoubleSideTicker.h"

@interface SLViewController : UIViewController <SLDoubleSideTickerDelegate> {
    
    SLDoubleSideTicker *_tickerA;
    SLDoubleSideTicker *_tickerB;
    SLDoubleSideTicker *_tickerC;    
}

@end
