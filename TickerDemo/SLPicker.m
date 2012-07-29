//
//  SLPicker.m
//  TickerDemo
//
//  Created by Sarah Lensing on 7/8/12.
//  Copyright (c) 2012 NYU. All rights reserved.
//

#import "SLPicker.h"

@interface SLContinuousTicker(private)
- (SLDoubleSideTicker *)nextTopTicker:(SLDoubleSideTicker *)ticker away:(int)numAway;
- (SLDoubleSideTicker *)nextBottomTicker:(SLDoubleSideTicker *)ticker away:(int)numAway;
@end

@implementation SLPicker

- (id)initWithFrame:(CGRect)frame superView:(UIView *)superview dataSource:(id<SLPickerDataSource>)dataSource {
    self = [super initWithFrame:frame superView:superview];
    if(self) {
        _dataSource = dataSource;
        _currentPage = 0;
        
        _topBalance = 0;
        _bottomBalance = 0;        
        
        _visibleTopTicker = _tickerA;
        _visibleBottomTicker = _tickerW;        
        
        _lastVisibleTickerForTopSet = _tickerA;
        _lastVisibleTickerForBottomSet = _tickerW;
        
    }
    return self;
}

- (SLDoubleSideTicker *)nextBottomTickerForBottomSet {
    if (_visibleBottomTicker == _tickerW) {
        return _tickerX;
    }
    else if (_visibleBottomTicker == _tickerX) {
        return _tickerY;
    }
    else if (_visibleBottomTicker == _tickerY) {
        return _tickerZ;
    }
    return _tickerW;

}

- (SLDoubleSideTicker *)prevTopTickerForBottomSet { //for change of dir when bottom > 0 ...need to look at top bc this is when we flip top>bottom
    if (_visibleTopTicker == _tickerW) {
        return _tickerZ;
    }
    else if (_visibleTopTicker == _tickerX) {
        return _tickerW;
    }
    else if (_visibleTopTicker == _tickerY) {
        return _tickerX;
    }
    return _tickerY;
}

- (SLDoubleSideTicker *)nextTopTickerForBottomSet {
    if (_bottomBalance == 0) {
        return _lastVisibleTickerForTopSet;
    }
    if (_visibleBottomTicker == _tickerW) {
        return _tickerX;
    }
    else if (_visibleBottomTicker == _tickerX) {
        return _tickerY;
    }
    else if (_visibleBottomTicker == _tickerY) {
        return _tickerZ;
    }
    return _tickerW;
}

- (SLDoubleSideTicker *)prevBottomTickerForTopSet { //for change of dir where top > 0
    if (_visibleBottomTicker == _tickerA) {
        return _tickerD;
    }
    else if (_visibleBottomTicker == _tickerB) {
        return _tickerA;
    }
    else if (_visibleBottomTicker == _tickerC) {
        return _tickerB;
    }
    return _tickerC;
}

- (SLDoubleSideTicker *)nextBottomTickerForTopSet {
    if (_topBalance == 0) {
        return _lastVisibleTickerForTopSet;
    }
    if (_visibleTopTicker == _tickerC) {
        return _tickerB;
    }
    else if (_visibleTopTicker == _tickerB) {
        return _tickerA;
    }
    else if (_visibleTopTicker == _tickerA) {
        return _tickerD;
    }
    return _tickerC;
}

- (SLDoubleSideTicker *)nextTopTickerForTopSet {
    if (_visibleTopTicker == _tickerA) {
        return _tickerB;
    }
    else if (_visibleTopTicker == _tickerB) {
        return _tickerC;
    }
    else if (_visibleTopTicker == _tickerC) {
        return _tickerD;
    }
    return _tickerA;
}

//TODO: figure out why anchor propery isnt working
- (BOOL)isATopTicker:(SLDoubleSideTicker *)ticker {
    return (ticker == _tickerA || ticker == _tickerB || ticker == _tickerC || ticker == _tickerD);
}

- (BOOL)isABottomTicker:(SLDoubleSideTicker *)ticker {
    return (ticker == _tickerW || ticker == _tickerX || ticker == _tickerY || ticker == _tickerZ);    
}

#pragma mark - SLDoubleSideTickerDelegate
- (void)ticker:(SLDoubleSideTicker *)ticker didUpdateRotationTransform:(CGFloat)y {
    [super ticker:ticker didUpdateRotationTransform:y];
//    NSLog(@"ticker:%@ transform:%f",ticker,y);
    
    if (_currentlyDraggingTicker != ticker) {
        _currentlyDraggingTicker = ticker;
        [self preloadData];        
    }
}

- (void)tickerFlippedToFront:(SLDoubleSideTicker *)ticker {
    [super tickerFlippedToFront:ticker];
    if ([self isATopTicker:ticker]) {
        _topBalance--;
        
        if (ticker == _visibleBottomTicker) {
            if (_topBalance > 0) {
                _visibleBottomTicker = [self prevBottomTickerForTopSet];
            } else {
                _visibleBottomTicker = [self nextBottomTickerForTopSet];        
            }
            _visibleTopTicker = ticker;
        } 
        if (_topBalance == 0) {
            _lastVisibleTickerForTopSet = ticker;
            _visibleBottomTicker = _lastVisibleTickerForBottomSet;
        }
        _currentPage++;
    }
    else {
        _bottomBalance--;
        
        if (ticker == _visibleTopTicker) {
            if (_bottomBalance > 0) {
                _visibleTopTicker = [self prevTopTickerForBottomSet];                        
            } else {
                _visibleTopTicker = [self nextTopTickerForBottomSet];        
            }
            _visibleBottomTicker = ticker;
        } 
        if (_bottomBalance == 0) {
            _lastVisibleTickerForBottomSet = ticker;
            _visibleTopTicker = _lastVisibleTickerForTopSet;
        }
        _currentPage--;
    }
    [self reloadData];
}

-(void)tickerFlippedToBack:(SLDoubleSideTicker *)ticker {
    [super tickerFlippedToBack:ticker];
    if ([self isATopTicker:ticker]) {
        if (_topBalance < 2) {
            _topBalance++;
        }
        
        if (ticker == _visibleTopTicker) {
            _visibleTopTicker = [self nextTopTickerForTopSet];
            _visibleBottomTicker = ticker;
        }
        _currentPage--;
    }
    else {
        if (_bottomBalance < 2) {
            _bottomBalance++;
        }
        
        if (ticker == _visibleBottomTicker) {
            _visibleBottomTicker = [self nextBottomTickerForBottomSet];        
            _visibleTopTicker = ticker;
        }  
        _currentPage++;
    }
    [self reloadData];    
}

- (void)reloadTopTicker:(SLDoubleSideTicker *)topTicker bottomTicker:(SLDoubleSideTicker *)bottomTicker atPage:(int)page {
    UIView *topView = [_dataSource topViewForPicker:self atPage:page];
    UIView *bottomView = [_dataSource bottomViewForPicker:self atPage:page];
    
    if([self isATopTicker:topTicker]) {
        topTicker.frontView = topView;
    } else {
        topTicker.backView = topView;
    }
    
    if([self isATopTicker:bottomTicker]) {
        bottomTicker.backView = bottomView;
    } else {
        bottomTicker.frontView = bottomView;
    }
}

- (void)preloadData {
    int page = _currentPage;
    
    //prev
    if(([self isATopTicker:_currentlyDraggingTicker] && _currentlyDraggingTicker.visibleState == TickerViewAnchorFront) || 
       ([self isABottomTicker:_currentlyDraggingTicker] && _currentlyDraggingTicker.visibleState == TickerViewAnchorBack)) {    
        page = page - 1;
        if (page < 0) {
            return;
        }
        
        UIView *topView = [_dataSource topViewForPicker:self atPage:page];
        UIView *bottomView = [_dataSource bottomViewForPicker:self atPage:page];
        
        if ([self isATopTicker:_visibleTopTicker]) {
            SLDoubleSideTicker *nextTop = [self nextTopTicker:_visibleTopTicker away:1];
            nextTop.frontView = topView;
            
            _visibleTopTicker.backView = bottomView;
        }
        else {
            SLDoubleSideTicker *nextTop = [self prevTopTickerForBottomSet];
            if (_bottomBalance == 1) {
                nextTop = _lastVisibleTickerForTopSet;
                nextTop.frontView = topView;
            }
            else {
                nextTop.backView = topView;
            }
            
            if ([self isABottomTicker:_visibleTopTicker]) {
                _visibleTopTicker.frontView = bottomView;
            }
            else {
                _visibleTopTicker.backView = bottomView;    
            }
        }
        
    }
    else { //next
        page = page + 1;
        if (page > [_dataSource numberOfItemsInPicker] - 1) {
            return;
        }
        
        UIView *topView = [_dataSource topViewForPicker:self atPage:page];
        UIView *bottomView = [_dataSource bottomViewForPicker:self atPage:page];
        
        if ([self isATopTicker:_visibleBottomTicker]) {
            SLDoubleSideTicker *nextBtm = [self prevBottomTickerForTopSet];
            if (_topBalance == 1) {
                nextBtm = _lastVisibleTickerForBottomSet;
                nextBtm.frontView = bottomView;                
            }
            else {
                nextBtm.backView = bottomView;
            }
            
            if ([self isATopTicker:_visibleBottomTicker]) {
                _visibleBottomTicker.frontView = topView;
            }
            else {
                _visibleBottomTicker.backView = topView;
            }
            
        }
        else {
            SLDoubleSideTicker *nextBtm = [self nextBottomTickerForBottomSet];
            nextBtm.frontView = bottomView;
            
            _visibleBottomTicker.backView = topView;
        }
    }
}


#pragma mark - SLPicker
- (void)reloadData {
    [self reloadTopTicker:_visibleTopTicker bottomTicker:_visibleBottomTicker atPage:_currentPage];
    
    _visibleTopTicker.enabled = (_currentPage != 0);
    _visibleBottomTicker.enabled = (_currentPage != [_dataSource numberOfItemsInPicker]-1);
}

@end
