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

- (void)ticker:(SLDoubleSideTicker *)ticker didUpdateRotationTransform:(CGFloat)y {
    [ticker bringToFront];
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
            
    _tickerA = [[SLDoubleSideTicker alloc] initWithFrame:CGRectMake(50, 50, 100, 150) superView:self.view];
    _tickerA.delegate = self;
    _tickerA.position = CGPointMake(150, 200);
    _tickerA.frontBackgroundColor = [UIColor greenColor];
    _tickerA.backBackgroundColor = [UIColor greenColor];
    _tickerA.frontView = [self labelWithText:@"Awesome.\n(front)"];
    _tickerA.backView = [self labelWithText:@"Awesome.\n(back)"];
    
    _tickerB = [[SLDoubleSideTicker alloc] initWithFrame:CGRectMake(50, 50, 100, 150) superView:self.view];
    _tickerB.delegate = self;
    _tickerB.position = CGPointMake(150, 200);
    _tickerB.frontBackgroundColor = [UIColor blueColor];
    _tickerB.backBackgroundColor = [UIColor blueColor];
    _tickerB.frontView = [self labelWithText:@"Success.\n(front)"];
    _tickerB.backView = [self labelWithText:@"Success.\n(back)"];
    
    _tickerC = [[SLDoubleSideTicker alloc] initWithFrame:CGRectMake(50, 50, 100, 150) superView:self.view];
    _tickerC.delegate = self;
    _tickerC.position = CGPointMake(150, 200);
    _tickerC.frontBackgroundColor = [UIColor orangeColor];
    _tickerC.backBackgroundColor = [UIColor orangeColor];
    _tickerC.frontView = [self labelWithText:@"Complete.\n(front)"];
    _tickerC.backView = [self labelWithText:@"Complete.\n(back)"];
}

@end
