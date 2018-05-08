//
//  NNFadeAnimationImageView.m
//  NNFadeAnimationImageView
//
//  Created by GuHaijun on 2018/4/27.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "NNFadeAnimationImageView.h"
#import "NSLayoutConstraint+NNVisualFormat.h"

@interface _NNAnimatedDisplayImageView : UIImageView @end
@implementation _NNAnimatedDisplayImageView @end
@interface _NNAnimatedFadeImageView : UIImageView @end
@implementation _NNAnimatedFadeImageView @end

@interface NNFadeAnimationImageView()

@property (nonatomic, strong) CADisplayLink *_nn_displayLink;
@property (nonatomic, assign) NSTimeInterval _nn_frameTimeCount;
@property (nonatomic, strong) UIImageView *_nn_displayImageView;
@property (nonatomic, strong) UIImageView *_nn_fadeImageView;

@end

@implementation NNFadeAnimationImageView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubview:self._nn_displayImageView];
        [self addSubview:self._nn_fadeImageView];
        NSArray<NSLayoutConstraint *> *constraints =
        [NSLayoutConstraint nn_constraintsWithVisualFormats:@[@"H:|[displayImageView]|", @"V:|[displayImageView]|",
                                                              @"H:|[fadeImageView]|", @"V:|[fadeImageView]|"]
                                                      views:@{@"displayImageView" : self._nn_displayImageView,
                                                              @"fadeImageView" : self._nn_fadeImageView}
         ];
        [NSLayoutConstraint activateConstraints:constraints];
    }
    return self;
}

- (void)setNn_animationState:(NNFadeAnimationState)nn_animationState {
    _nn_animationState = nn_animationState;
    switch (_nn_animationState) {
        case NNFadeAnimationStateStart: {
            if (self.nn_hasAnimation) {
                self.nn_animating = true;
            }
            else {
                [self _nn_animationFinished];
                _nn_animationState = NNFadeAnimationStateEnd;
            }
            break;
        }
        case NNFadeAnimationStatePause: {
            self.nn_animating = false;
            break;
        }
        case NNFadeAnimationStateEnd: {
            [self _nn_animationFinished];
            break;
        }
            
        default:
            break;
    }
}

- (void)setNn_image:(UIImage *)nn_image {
    _nn_image = nn_image;
    self._nn_displayImageView.image = nn_image;
}

- (void)setNn_toImage:(UIImage *)nn_toImage {
    _nn_toImage = nn_toImage;
    self._nn_fadeImageView.image = _nn_toImage;
}

- (void)setNn_animationProcess:(CGFloat)nn_animationProcess {
    _nn_animationProcess = nn_animationProcess;
    
    if (self.nn_animationState == NNFadeAnimationStateEnd) {
        return;
    }
    if (self.nn_animationState == NNFadeAnimationStateStart) {
        self.nn_animationState = NNFadeAnimationStatePause;
    }
    self.nn_animationProcessing = _nn_animationProcess;
    if (self.nn_animationProcessing >= 1.0f || self.nn_animationProcessing < 0.0f) {
        self.nn_animationProcessing = 0.0f;
        self.nn_animationState = NNFadeAnimationStateEnd;
    }
    [self _nn_transitImageView];
}

- (void)setNn_hasTranslucentEffect:(BOOL)nn_hasTranslucentEffect {
    _nn_hasTranslucentEffect = nn_hasTranslucentEffect;
    [self _nn_transitImageView];
}

- (void)setNn_animationProcessing:(CGFloat)nn_animationProcessing {
    _nn_animationProcessing = nn_animationProcessing;
}

- (void)setNn_animating:(BOOL)nn_animating {
    
    if (nn_animating == true &&
        self._nn_displayLink == nil &&
        self.nn_animationDuration != 0 &&
        self.nn_frameDuration != 0) {
        [self _nn_startLinkTick];
        _nn_animating = nn_animating;
        return;
    }
    
    if (nn_animating == false &&
        self._nn_displayLink != nil) {
        [self _nn_endLinkTick];
        self._nn_frameTimeCount = .0f;
    }
    
    _nn_animating = false;
}

- (void)_nn_startLinkTick {
    self._nn_displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(_nn_handleLinkTick)];
    [self._nn_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)_nn_endLinkTick {
    self._nn_displayLink.paused = true;
    [self._nn_displayLink invalidate];
    self._nn_displayLink = nil;
}

- (void)_nn_handleLinkTick {
    
    self._nn_frameTimeCount += self._nn_displayLink.duration;
    if (self._nn_frameTimeCount < self.nn_frameDuration) {
        return;
    }
    
    CGFloat deltaProcess = self._nn_frameTimeCount / self.nn_animationDuration;
    self.nn_animationProcessing += (self.nn_isReversed ? (-deltaProcess) : deltaProcess);
    self._nn_frameTimeCount = 0.0;
    
    
    if (self.nn_animationProcessing >= 1.0f || self.nn_animationProcessing < 0.0f) {
        self.nn_animating = false;
        self.nn_animationProcessing = 0.0f;
        self.nn_animationState = NNFadeAnimationStateEnd;
    }
    
    [self _nn_transitImageView];
}

- (void)_nn_animationFinished {
    if (!self.nn_isReversed) {
        self.nn_image = self.nn_toImage;
        self.nn_toImage = nil;
    }
}

- (void)_nn_transitImageView {
    self._nn_displayImageView.alpha = self.nn_hasTranslucentEffect ? (1 - self.nn_animationProcessing) : 1.0f;
    self._nn_fadeImageView.alpha = self.nn_animationProcessing;
}

- (UIImageView *)_nn_fadeImageView {
    if (!__nn_fadeImageView) {
        __nn_fadeImageView = [_NNAnimatedFadeImageView new];
        __nn_fadeImageView.translatesAutoresizingMaskIntoConstraints = false;
    }
    return __nn_fadeImageView;
}

- (UIImageView *)_nn_displayImageView {
    if (!__nn_displayImageView) {
        __nn_displayImageView = [_NNAnimatedDisplayImageView new];
        __nn_displayImageView.translatesAutoresizingMaskIntoConstraints = false;
    }
    return __nn_displayImageView;
}

@end
