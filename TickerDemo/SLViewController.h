//
//  SLViewController.h
//  TickerDemo
//
//  Created by Sarah Lensing on 7/6/12.
//  Copyright (c) 2012 NYU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLTickerView.h"

@interface SLViewController : UIViewController <SLTickerViewDelegate> {
    SLTickerView *_ticker;
    SLTickerView *_ticker2;
}

@end
