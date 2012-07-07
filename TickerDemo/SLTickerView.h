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

@class SLTickerView;

@protocol SLTickerViewDelegate <NSObject>
-(void)tickerView:(SLTickerView *)tickerView didUpdateRotationTransform:(CGFloat)y;
@end

@interface SLTickerView : UIView<UIGestureRecognizerDelegate> {
    CGFloat _minX;
    CGFloat _maxX;
    CGFloat _flipSpeedThrottle;
    
    BOOL _normalPanStart;
    UIPanGestureRecognizer *_pan;    
}

@property (nonatomic, assign) id<SLTickerViewDelegate>delegate;
@property (nonatomic, assign) TickerViewFlipSpeed flipSpeed;
@property (nonatomic, assign) TickerViewAnchorType anchorType;

- (void)updateRotationTransform:(CGFloat)y;

@end

