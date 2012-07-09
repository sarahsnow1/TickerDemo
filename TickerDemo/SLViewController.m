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

@synthesize topImageViews = _topImageViews;
@synthesize bottomImageViews = _bottomImageViews;

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

- (void)setupImageViewArrays {
    NSMutableArray *tops = [NSMutableArray array];
    NSMutableArray *bottoms = [NSMutableArray array];

    for (int i = 0; i < 10; i++) {
        [tops addObject:[self labelWithText:[NSString stringWithFormat:@"%i T",i]]];
        [bottoms addObject:[self labelWithText:[NSString stringWithFormat:@"%i B",i]]];        
    }
    self.topImageViews = tops;
    self.bottomImageViews = bottoms;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
      
    [self setupImageViewArrays];
    
    _ticker = [[SLPicker alloc] initWithFrame:CGRectMake(50, 50, 100, 150) superView:self.view dataSource:self];
    _ticker.position = CGPointMake(250, 200);
    [_ticker reloadData];
    
    _testTicker = [[SLTickerView alloc] initWithFrame:CGRectMake(50, 50, 100, 150)];
    _testTicker.backgroundColor = [UIColor greenColor];
    _testTicker.layer.position = CGPointMake(100, 200);
    _testTicker.anchorType = TickerViewAnchorTop;
    _testTicker.delegate = self;
    [self.view addSubview:_testTicker];
    
}

#pragma mark - SLPickerDataSource
- (NSUInteger)numberOfItemsInPicker {
    return 10;
}

- (UIView *)topViewForPicker:(SLContinuousTicker *)picker atPage:(NSUInteger)page {
    return [_topImageViews objectAtIndex:page];
}

- (UIView *)bottomViewForPicker:(SLContinuousTicker *)picker atPage:(NSUInteger)page {
    return [_bottomImageViews objectAtIndex:page];    
}

@end
