//
//  NNAnimatedImageView.m
//  NNAnimatedImageView
//
//  Created by GuHaijun on 2018/4/27.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "NNAnimatedImageView.h"
#import "UIImage+NNImageTransition.h"
#import "NSLayoutConstraint+NNVisualFormat.h"
#import "UIImage+NNImageWithColor.h"

@interface _NNAnimatedDisplayImageView : UIImageView @end
@implementation _NNAnimatedDisplayImageView @end
@interface _NNAnimatedFadeImageView : UIImageView @end
@implementation _NNAnimatedFadeImageView @end

@interface NNAnimatedImageView()

@property (nonatomic, strong) CADisplayLink *nn_displayLink;
@property (nonatomic, assign) NSTimeInterval nn_frameTimeCount;
@property (nonatomic, strong) UIImageView *displayImageView;
@property (nonatomic, strong) UIImageView *fadeImageView;

@end

@implementation NNAnimatedImageView

- (instancetype)init {
    self = [super init];
    self.nn_animationProcess = 0.0f;
    [self addSubview:self.displayImageView];
    [self addSubview:self.fadeImageView];
    
    NSArray<NSLayoutConstraint *> *(^makeViewConstraint)(NSDictionary *view) = ^(NSDictionary *view) {
        return [NSLayoutConstraint nn_constraintsWithVisualFormats:@[[NSString stringWithFormat:@"H:|[%@]|", view.allKeys.lastObject] ,
                                                                     [NSString stringWithFormat:@"V:|[%@]|", view.allKeys.lastObject]]
                                                             views:view];
    };
    [NSLayoutConstraint activateConstraints:makeViewConstraint(@{@"displayImageView" : self.displayImageView})];
    [NSLayoutConstraint activateConstraints:makeViewConstraint(@{@"fadeImageView" : self.fadeImageView})];
    
    return self;
}

- (void)setNn_image:(UIImage *)nn_image {
    _nn_image = nn_image;
    self.displayImageView.image = nn_image;
    [self transitImageView];
}

- (void)setImage:(UIImage *)image {
}

- (void)setNn_toImage:(UIImage *)nn_toImage {
    _nn_toImage = nn_toImage;
    self.fadeImageView.image = _nn_toImage;
    [self transitImageView];
}

- (void)setNn_animationProcess:(CGFloat)nn_animationProcess {
    _nn_animationProcess = nn_animationProcess;
    self.nn_animating = false;
    self.nn_animationProcessing = _nn_animationProcess;
    [self transitImageView];
}

- (void)setNn_animating:(BOOL)nn_animating {
    
    if (nn_animating == true &&
        self.nn_displayLink == nil &&
        self.nn_animationDuration != 0 &&
        self.nn_frameDuration != 0) {
        CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleLinkTick)];
        [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        self.nn_displayLink = link;
        _nn_animating = nn_animating;
        return;
    }
    
    if (nn_animating == false &&
        self.nn_displayLink != nil) {
        CADisplayLink *link = self.nn_displayLink;
        link.paused = true;
        [link invalidate];
        self.nn_frameTimeCount = .0f;
        self.nn_displayLink = nil;
    }
    
    _nn_animating = false;
}

- (void)handleLinkTick {
    
    self.nn_frameTimeCount += self.nn_displayLink.duration;
    if (self.nn_frameTimeCount < self.nn_frameDuration) {
        return;
    }
    
    CGFloat deltaProcess = self.nn_frameTimeCount / self.nn_animationDuration;
    self.nn_animationProcessing += (self.nn_isReversed ? (-deltaProcess) : deltaProcess);
    self.nn_frameTimeCount = 0.0;
    
    
    if (self.nn_animationProcessing >= 1.0f || self.nn_animationProcessing < 0.0f) {
        self.nn_animating = false;
        self.nn_animationProcessing = 0.0f;
        [self nn_animationFinished];
    }
    
    [self transitImageView];
}

- (void)nn_animationFinished {
    if (!self.nn_isReversed) {
        self.displayImageView.image = self.fadeImageView.image;
    }
}

- (UIImageView *)fadeImageView {
    if (!_fadeImageView) {
        _fadeImageView = [_NNAnimatedFadeImageView new];
        _fadeImageView.translatesAutoresizingMaskIntoConstraints = false;
    }
    return _fadeImageView;
}

- (UIImageView *)displayImageView {
    if (!_displayImageView) {
        _displayImageView = [_NNAnimatedDisplayImageView new];
        _displayImageView.translatesAutoresizingMaskIntoConstraints = false;
    }
    return _displayImageView;
}

- (void)transitImageView {
    self.displayImageView.alpha = (1 - self.nn_animationProcessing);
    self.fadeImageView.alpha = self.nn_animationProcessing;
}

//- (void)refreshImage {
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        UIImage *image = [UIImage imageTransitionFromImage:self.nn_fromImage
//                                                   toImage:self.nn_toImage
//                                                   process:self.nn_animationProcessing];
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            self.image = image;
//        });
//    });
//}

@end
