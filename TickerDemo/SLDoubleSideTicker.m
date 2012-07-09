//
//  SLDoubleSideTickerView.m
//  TickerDemo
//
//  Created by Sarah Lensing on 7/8/12.
//  Copyright (c) 2012 NYU. All rights reserved.
//

#import "SLDoubleSideTicker.h"

@implementation SLDoubleSideTicker

@synthesize delegate = _delegate;
@synthesize anchorType = _anchorType;
@synthesize flipSpeed = _flipSpeed;
@synthesize position = _position;
@synthesize backBackgroundColor = _backBackgroundColor;
@synthesize frontBackgroundColor = _frontBackgroundColor;
@synthesize backView = _backView;
@synthesize frontView = _frontView;
@synthesize hidden = _hidden;
@synthesize enabled = _enabled;

- (void)createFrontTicker {
    _frontTicker = [[SLTickerView alloc] initWithFrame:_frame];
    _frontTicker.delegate = self;
    _frontTicker.layer.doubleSided = NO;    
    [_view addSubview:_frontTicker];    
}

- (void)createBackTicker {
    _backTicker = [[SLTickerView alloc] initWithFrame:_frame];
    [_view addSubview:_backTicker];    
}


- (id)initWithFrame:(CGRect)frame superView:(UIView *)superview {
    self = [super init];
    if (self) {
        _frame = frame;
        _view = superview;
        [self createBackTicker];        
        [self createFrontTicker];
    }
    return self;
}

#pragma mark - Overwrite Setters
- (void)setAnchorType:(TickerViewAnchorType)anchorType {
    _backTicker.anchorType = anchorType;
    _frontTicker.anchorType = anchorType;
    _anchorType = anchorType;
}

- (void)setFlipSpeed:(TickerViewFlipSpeed)flipSpeed {
    _backTicker.flipSpeed = flipSpeed;
    _frontTicker.flipSpeed = flipSpeed;
    _flipSpeed = flipSpeed;
}

- (void)setPosition:(CGPoint)position {
    _frontTicker.layer.position = position;
    _backTicker.layer.position = position;    
    _position = position;
}

- (void)setBackBackgroundColor:(UIColor *)backBackgroundColor {
    _backTicker.backgroundColor = backBackgroundColor;
    _backBackgroundColor = backBackgroundColor;
}

- (void)setFrontBackgroundColor:(UIColor *)frontBackgroundColor {
    _frontTicker.backgroundColor = frontBackgroundColor;
    _frontBackgroundColor = frontBackgroundColor;
}

- (void)setBackView:(UIView *)backView {
    if (_backView) {
        [_backView removeFromSuperview];
    }
    backView.layer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    [_backTicker addSubview:backView];
    _backView = backView;
}

- (void)setFrontView:(UIView *)backView {
    if (_frontView) {
        [_frontView removeFromSuperview];
    }    
    [_frontTicker addSubview:backView];
    _frontView = backView;
}

#pragma mark - SLTickerViewDelegate
- (void)tickerView:(SLTickerView *)tickerView didUpdateRotationTransform:(CGFloat)y {
    [_backTicker updateRotationTransform:y];
    if (_delegate && [_delegate respondsToSelector:@selector(ticker:didUpdateRotationTransform:)]) {
        [_delegate ticker:self didUpdateRotationTransform:y];
    }
}

- (void)tickerViewFlippedToFront:(SLTickerView *)tickerView {
    if (_delegate && [_delegate respondsToSelector:@selector(tickerFlippedToFront:)]) {
        [_delegate tickerFlippedToFront:self];
    }
}

-(void)tickerViewFlippedToBack:(SLTickerView *)tickerView {
    if (_delegate && [_delegate respondsToSelector:@selector(tickerFlippedToBack:)]) {
        [_delegate tickerFlippedToBack:self];
    }    
}

#pragma mark - SLDoubleSideTickerView
- (void)bringToFront {
    [_view bringSubviewToFront:_backTicker];
    [_view bringSubviewToFront:_frontTicker];    
}

- (void)sendToBack {
    [_view sendSubviewToBack:_backTicker];
    [_view sendSubviewToBack:_frontTicker];
}

- (void)updateRotationTransform:(CGFloat)y {
    [_frontTicker updateRotationTransform:y];
}

- (void)reset {
    self.hidden = YES;
}

- (void)setHidden:(BOOL)hidden {
    id refToDelegate = _delegate;
    if (hidden) {
        [UIView animateWithDuration:0 animations:^{
            [_backTicker.layer setValue:[NSNumber numberWithBool:hidden] forKeyPath:@"hidden"]; 
            [_frontTicker.layer setValue:[NSNumber numberWithBool:hidden] forKeyPath:@"hidden"];
        } completion:^(BOOL finished) {
            _delegate = nil;
            [UIView animateWithDuration:0 animations:^{
                [self updateRotationTransform:0];
            } completion:^(BOOL finished) {
                _delegate = refToDelegate;
                [self sendToBack];
                [_view insertSubview:_frontTicker aboveSubview:_backTicker];
                self.hidden = NO;
            }];        
        }];        
    }
    else {
        [UIView animateWithDuration:0 animations:^{
            [_backTicker.layer setValue:[NSNumber numberWithBool:hidden] forKeyPath:@"hidden"]; 
            [_frontTicker.layer setValue:[NSNumber numberWithBool:hidden] forKeyPath:@"hidden"];
        }];
    }
}

- (void)setEnabled:(BOOL)enabled {
    _backTicker.enabled = enabled;
    _frontTicker.enabled = enabled;
    _enabled = enabled;
}

@end
