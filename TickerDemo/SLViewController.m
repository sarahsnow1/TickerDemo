//
//  SLViewController.m
//  TickerDemo
//
//  Created by Sarah Lensing on 7/6/12.
//  Copyright (c) 2012 NYU. All rights reserved.
//

#import "SLViewController.h"


@interface SLViewController ()

@end

@implementation SLViewController

- (void)ticker:(SLContinuousTicker *)ticker didUpdateRotationTransform:(CGFloat)y {
//    [ticker bringToFront];
}

-(void)tickerView:(SLTickerView *)tickerView didUpdateRotationTransform:(CGFloat)y {
    //do nothing
}

- (void)tickerViewFlippedToFront:(SLTickerView *)tickerView {
    NSLog(@"front");
}

- (void)tickerViewFlippedToBack:(SLTickerView *)tickerView {
    NSLog(@"back");    
}

- (UILabel *)labelWithText:(NSString *)text {
    UILabel *lbl = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 150)] autorelease];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.textAlignment = UITextAlignmentCenter;
    lbl.adjustsFontSizeToFitWidth = YES;
    lbl.text = text;
    return lbl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
            
    _ticker = [[SLContinuousTicker alloc] initWithFrame:CGRectMake(50, 50, 100, 150) superView:self.view];
    _ticker.delegate = self;
    _ticker.position = CGPointMake(250, 200);
    
    _testTicker = [[SLTickerView alloc] initWithFrame:CGRectMake(50, 50, 100, 150)];
    _testTicker.backgroundColor = [UIColor greenColor];
    _testTicker.layer.position = CGPointMake(100, 200);
    _testTicker.anchorType = TickerViewAnchorTop;
    _testTicker.delegate = self;
    [self.view addSubview:_testTicker];
    
}

@end
