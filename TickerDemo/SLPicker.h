//
//  SLPicker.h
//  TickerDemo
//
//  Created by Sarah Lensing on 7/8/12.
//  Copyright (c) 2012 NYU. All rights reserved.
//

#import "SLContinuousTicker.h"

@class SLPicker;
@protocol SLPickerDataSource <NSObject>
- (NSUInteger)numberOfItemsInPicker;
- (UIView *)topViewForPicker:(SLPicker *)picker atPage:(NSUInteger)page;
- (UIView *)bottomViewForPicker:(SLPicker *)picker atPage:(NSUInteger)page;
@end

@interface SLPicker : SLContinuousTicker {
    id<SLPickerDataSource>_dataSource;
    int _currentPage;
    
    int _topBalance;
    int _bottomBalance;
    SLDoubleSideTicker *_visibleTopTicker;
    SLDoubleSideTicker *_visibleBottomTicker;        
    
    SLDoubleSideTicker *_lastVisibleTickerForTopSet;
    SLDoubleSideTicker *_lastVisibleTickerForBottomSet;    
}

- (id)initWithFrame:(CGRect)frame superView:(UIView *)superview dataSource:(id<SLPickerDataSource>)dataSource;
- (void)reloadData;

@end
