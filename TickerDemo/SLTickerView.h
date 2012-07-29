//
//  SLTickerView.h
//  TickerDemo
//
//  Created by Sarah Lensing on 7/6/12.
//  Copyright (c) 2012 NYU. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    TickerViewFlipSpeedFast,
    TickerViewFlipSpeedNormal,
    TickerViewFlipSpeedSlow
}TickerViewFlipSpeed;

typedef enum {
    TickerViewAnchorTop,
    TickerViewAnchorBottom
}TickerViewAnchorType;

typedef enum {
    TickerViewAnchorFront,
    TickerViewAnchorBack
}TickerViewVisibleState;

@class SLTickerView;

@protocol SLTickerViewDelegate <NSObject>
@optional
-(void)tickerView:(SLTickerView *)tickerView didUpdateRotationTransform:(CGFloat)y;
- (void)tickerViewFlippedToFront:(SLTickerView *)tickerView;
- (void)tickerViewFlippedToBack:(SLTickerView *)tickerView;
@end

@interface SLTickerView : UIView<UIGestureRecognizerDelegate> {
    CGFloat _minX;
    CGFloat _maxX;
    CGFloat _flipSpeedThrottle;
    
    BOOL _normalPanStart;
    UIPanGestureRecognizer *_pan;    
    
    TickerViewVisibleState _visibleState;
    BOOL _flipping;
}

@property (nonatomic, assign) id<SLTickerViewDelegate>delegate;
@property (nonatomic, assign) TickerViewFlipSpeed flipSpeed;
@property (nonatomic, assign) TickerViewAnchorType anchorType;
@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, assign) CGFloat autoFlipVelocity;
@property (nonatomic, readonly) TickerViewVisibleState visibleState;

- (void)updateRotationTransform:(CGFloat)y;
- (void)flip;

@end

