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

- (void)tickerView:(SLTickerView *)tickerView didUpdateRotationTransform:(CGFloat)y {
    [_ticker2 updateRotationTransform:y];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _ticker2 = [[SLTickerView alloc] initWithFrame:CGRectMake(50, 50, 100, 150)];
    _ticker2.layer.position = CGPointMake(80, 480/2+2);
    _ticker2.backgroundColor = [UIColor redColor];
    [self.view addSubview:_ticker2];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 150)];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.textAlignment = UITextAlignmentCenter;
    lbl.text = @"Success.";
    [_ticker2 addSubview:lbl];
    
    _ticker = [[SLTickerView alloc] initWithFrame:CGRectMake(50, 50, 100, 150)];
    _ticker.layer.position = CGPointMake(320-80, 480/2);
    _ticker.backgroundColor = [UIColor blueColor];
    _ticker.delegate = self;
    [self.view addSubview:_ticker];
    
    lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 150)];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.textAlignment = UITextAlignmentCenter;
    lbl.text = @"Awesome.";
    [_ticker addSubview:lbl];
}

@end
