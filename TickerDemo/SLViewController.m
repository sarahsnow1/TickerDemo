//
//  SLViewController.m
//  TickerDemo
//
//  Created by Sarah Lensing on 7/6/12.
//  Copyright (c) 2012 NYU. All rights reserved.
//

#import "SLViewController.h"
#import "SLContinuousTicker.h"
#import "SLDoubleSideTicker.h"

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

- (UIColor *)randomColor {
    return [UIColor colorWithRed:((float)rand() / RAND_MAX)
                        green:((float)rand() / RAND_MAX)
                         blue:((float)rand() / RAND_MAX)
                        alpha:1.0f];
}

- (void)setupImageViewArrays {
    NSMutableArray *tops = [NSMutableArray array];
    NSMutableArray *bottoms = [NSMutableArray array];

    for (int i = 0; i < 10; i++) {
        UIColor *color = [self randomColor];
        
        UILabel *topLabel = [self labelWithText:[NSString stringWithFormat:@"%i T",i]];
        topLabel.backgroundColor = color;
        [tops addObject:topLabel];
        
        UILabel *bottomLabel = [self labelWithText:[NSString stringWithFormat:@"%i B",i]];
        bottomLabel.backgroundColor = color;
        [bottoms addObject:bottomLabel];        
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
    
    
//    _doubleSide = [[SLDoubleSideTicker alloc] initWithFrame:CGRectMake(50, 150, 100, 150) superView:self.view];
//    _doubleSide.frontView = [self labelWithText:@"front"];
//    UILabel *lbl = [self labelWithText:@"back"];
//    lbl.backgroundColor = [UIColor redColor];
//    _doubleSide.backView = lbl;
//    _doubleSide.frontBackgroundColor = [UIColor greenColor];
//    _doubleSide.backBackgroundColor = [UIColor blueColor];
//    _doubleSide.anchorType = TickerViewAnchorBottom;
    
    _testTicker = [[SLContinuousTicker alloc] initWithFrame:CGRectMake(50, 150, 100, 150) superView:self.view];
    _testTicker.position = CGPointMake(100, 200);
    
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
