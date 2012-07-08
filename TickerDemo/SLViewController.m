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

- (void)tickerView:(SLDoubleSideTicker *)tickerView didUpdateRotationTransform:(CGFloat)y {
    //do stuff
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
    _tickerA.backBackgroundColor = [UIColor blueColor];
    _tickerA.frontView = [self labelWithText:@"Awesome.\n(front)"];
    _tickerA.backView = [self labelWithText:@"Awesome.\n(back)"];
}

@end
