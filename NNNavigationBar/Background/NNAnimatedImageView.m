//
//  NNAnimatedImageView.m
//  NNAnimatedImageView
//
//  Created by GuHaijun on 2018/4/27.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "NNAnimatedImageView.h"
#import "NSLayoutConstraint+NNVisualFormat.h"

@interface _NNAnimatedDisplayImageView : UIImageView @end
@implementation _NNAnimatedDisplayImageView @end
@interface _NNAnimatedFadeImageView : UIImageView @end
@implementation _NNAnimatedFadeImageView @end

@interface NNAnimatedImageView()

@property (nonatomic, strong) CADisplayLink *_nn_displayLink;
@property (nonatomic, assign) NSTimeInterval _nn_frameTimeCount;
@property (nonatomic, strong) UIImageView *_nn_displayImageView;
@property (nonatomic, strong) UIImageView *_nn_fadeImageView;

@end

@implementation NNAnimatedImageView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubview:self._nn_displayImageView];
        [self addSubview:self._nn_fadeImageView];
        NSArray<NSLayoutConstraint *> *(^makeViewConstraint)(NSDictionary *view) = ^(NSDictionary *view) {
            return [NSLayoutConstraint nn_constraintsWithVisualFormats:@[[NSString stringWithFormat:@"H:|[%@]|", view.allKeys.lastObject] ,
                                                                         [NSString stringWithFormat:@"V:|[%@]|", view.allKeys.lastObject]]
                                                                 views:view];
        };
        [NSLayoutConstraint activateConstraints:makeViewConstraint(@{@"displayImageView" : self._nn_displayImageView})];
        [NSLayoutConstraint activateConstraints:makeViewConstraint(@{@"fadeImageView" : self._nn_fadeImageView})];
    }
    return self;
}

- (void)setNn_image:(UIImage *)nn_image {
    _nn_image = nn_image;
    self._nn_displayImageView.image = nn_image;
    [self _nn_transitImageView];
}

- (void)setImage:(UIImage *)image {
}

- (void)setNn_toImage:(UIImage *)nn_toImage {
    _nn_toImage = nn_toImage;
    self._nn_fadeImageView.image = _nn_toImage;
    [self _nn_transitImageView];
}

- (void)setNn_animationProcess:(CGFloat)nn_animationProcess {
    _nn_animationProcess = nn_animationProcess;
    self.nn_animating = false;
    self.nn_animationProcessing = _nn_animationProcess;
    [self _nn_transitImageView];
}

- (void)setNn_animating:(BOOL)nn_animating {
    
    if (nn_animating == true &&
        self._nn_displayLink == nil &&
        self.nn_animationDuration != 0 &&
        self.nn_frameDuration != 0) {
        CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(_nn_handleLinkTick)];
        [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        self._nn_displayLink = link;
        _nn_animating = nn_animating;
        return;
    }
    
    if (nn_animating == false &&
        self._nn_displayLink != nil) {
        CADisplayLink *link = self._nn_displayLink;
        link.paused = true;
        [link invalidate];
        self._nn_frameTimeCount = .0f;
        self._nn_displayLink = nil;
    }
    
    _nn_animating = false;
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
        [self _nn_animationFinished];
    }
    
    [self _nn_transitImageView];
}

- (void)_nn_animationFinished {
    if (!self.nn_isReversed) {
        self._nn_displayImageView.image = self._nn_fadeImageView.image;
        self._nn_fadeImageView.image = nil;
    }
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

- (void)_nn_transitImageView {
    self._nn_displayImageView.alpha = self.nn_animationAlpha ? (1 - self.nn_animationProcessing) : 1.0f;
    self._nn_fadeImageView.alpha = self.nn_animationProcessing;
}

@end
