        //
//  SLTickerView.m
//  TickerDemo
//
//  Created by Sarah Lensing on 7/6/12.
//  Copyright (c) 2012 NYU. All rights reserved.
//

#import "SLTickerView.h"

@implementation SLTickerView

@synthesize delegate = _delegate;
@synthesize flipSpeed = _flipSpeed;
@synthesize anchorType = _anchorType;

- (void)addPerspective {
    CATransform3D myTransform = CATransform3DIdentity;
    float zzz= 1000;
    myTransform.m34 = -1/zzz;
    self.layer.transform = myTransform;    
    //self.layer.sublayerTransform = myTransform;
}

- (void)configureAnchor {
    self.anchorType = TickerViewAnchorBottom;
}

- (void)configureFlipSpeed {
    self.flipSpeed = TickerViewFlipSpeedNormal;
}

- (void)configureMinMax {
    _minX = 0;
    _maxX = M_PI;
}

- (void)addGesture {
    _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(doPan:)];
    [_pan addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:nil];
    [self addGestureRecognizer:_pan];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        _visibleState = TickerViewAnchorFront;
        
        [self addPerspective];
        [self configureAnchor];
        [self configureFlipSpeed];
        [self configureMinMax];
        [self addGesture];   
        
    }
    return self;
}

- (CGFloat)valueForGesture:(UIPanGestureRecognizer *)gesture {
    
    CGRect myNormalized = [self convertRect:self.bounds toView:self.superview];
    float myHeight = self.bounds.size.height;    
    float myTop = myNormalized.origin.y;
    float totalAvailableProgress = (myTop + 2*myHeight);
    
    float translation = [gesture translationInView:self.superview].y;
    float absTranslation = fabsf(translation);
    float myTranslation = [gesture translationInView:self].y; 
    
    if ((translation < 0 && fabsf(myTranslation) != INFINITY && _normalPanStart && myTranslation < 0) || 
        (_normalPanStart && _anchorType == TickerViewAnchorTop && translation < 0) //prevent over translation if top anchor and above fold
        ) {
        absTranslation = 0;
    } else if ((!_normalPanStart && translation > 0)) {
        absTranslation = totalAvailableProgress;
    } else {
        absTranslation *= _flipSpeedThrottle;        
    }
    
    float progress = (absTranslation / totalAvailableProgress ) * M_PI;
    
    if ((!_normalPanStart && translation < 0)) {
        progress = M_PI - fabsf(progress);
    } 
    
    if (_anchorType == TickerViewAnchorBottom) {
        progress= -1*progress;  //so that it flips towards us and not away
    } else {
        progress = M_PI - progress;
    }
    //    NSLog(@"test:%f myTranslation:%f translation:%f   progress:%f",myTranslation, translation, absTranslation, progress);
    return progress;
}

- (void)doPan:(UIPanGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        CGRect myNormalized = [self convertRect:self.bounds toView:self.superview];
        _normalPanStart = (self.layer.position.y != myNormalized.origin.y);         
    }
    else if (gesture.state != UIGestureRecognizerStateChanged) {
        return;
    }
    CGFloat y = [self valueForGesture:gesture];
    [self updateRotationTransform:y];
}

- (void)setFlipSpeed:(TickerViewFlipSpeed)flipSpeed {
    _flipSpeed = flipSpeed;
    switch (flipSpeed) {
        case TickerViewFlipSpeedFast:
            _flipSpeedThrottle = 1.25;
            break;
        case TickerViewFlipSpeedNormal:
            _flipSpeedThrottle = 1;
            break;
        case TickerViewFlipSpeedSlow:
            _flipSpeedThrottle = .75;
            break;
        default:
            break;
    }
}

- (void)setAnchorType:(TickerViewAnchorType)anchorType {
    _anchorType = anchorType;
    switch (anchorType) {
        case TickerViewAnchorTop:
            self.layer.anchorPoint = CGPointMake(0.5, 0);
            break;
        case TickerViewAnchorBottom:
            self.layer.anchorPoint = CGPointMake(0.5, 1);
            break;
        default:
            break;
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    int newChange = [[change objectForKey:@"new"] intValue];
    if ((object == _pan) && (newChange == 3)) {
        CGFloat y = fabsf([self valueForGesture:_pan]);
        CGFloat newY;
        if (y < M_PI_2) {
            newY = 0;
        } else {
            newY = M_PI;
        }
        [UIView animateWithDuration:0.5 animations:^{
            [self updateRotationTransform:newY];
        } completion:^(BOOL finished) {
            [self handleFlippedDelegateCalls:newY];
        }];
    }
}

- (void)updateRotationTransform:(CGFloat)y {
    [self.layer setValue:[NSNumber numberWithFloat:y] forKeyPath:@"transform.rotation.x"]; 
    if (_delegate && [_delegate respondsToSelector:@selector(tickerView:didUpdateRotationTransform:)]) {
        [_delegate tickerView:self didUpdateRotationTransform:y];        
    }    
    [self handleFlippedDelegateCalls:y];    
}

- (void)handleFlippedDelegateCalls:(CGFloat)y {
    if (_pan.state != UIGestureRecognizerStateBegan && _pan.state != UIGestureRecognizerStateChanged) {
        
        if (fabsf(y) == 0 && _visibleState != TickerViewAnchorFront) {
            _visibleState = TickerViewAnchorFront;
            if (_delegate && [_delegate respondsToSelector:@selector(tickerViewFlippedToFront:)]) {
                [_delegate tickerViewFlippedToFront:self];                
            }
        }
        else if (fabsf(y) >= 3.141 && _visibleState != TickerViewAnchorBack) { //approx of M_PI
            _visibleState = TickerViewAnchorBack;
            if (_delegate && [_delegate respondsToSelector:@selector(tickerViewFlippedToBack:)]) {
                [_delegate tickerViewFlippedToBack:self];
            }
        }
    }
}


@end
