//
//  NNAnimatedImageView.m
//  NNAnimatedImageView
//
//  Created by GuHaijun on 2018/4/27.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "NNAnimatedImageView.h"
#import "UIImage+NNImageTransition.h"

@interface NNAnimatedImageView()

@property (nonatomic, strong) CADisplayLink *nn_displayLink;
@property (nonatomic, assign) NSTimeInterval nn_frameTimeCount;

@end

@implementation NNAnimatedImageView

- (void)setNn_fromImage:(UIImage *)nn_fromImage {
    _nn_fromImage = nn_fromImage;
    self.image = [UIImage imageTransitionFromImage:self.nn_fromImage
                                           toImage:self.nn_toImage
                                           process:self.nn_animationProcessing];
}

- (void)setNn_toImage:(UIImage *)nn_toImage {
    _nn_toImage = nn_toImage;
    self.image = [UIImage imageTransitionFromImage:self.nn_fromImage
                                           toImage:self.nn_toImage
                                           process:self.nn_animationProcessing];
}

- (void)setNn_animationProcess:(CGFloat)nn_animationProcess {
    _nn_animationProcess = nn_animationProcess;
    self.nn_animating = false;
    self.nn_animationProcessing = _nn_animationProcess;
    self.image = [UIImage imageTransitionFromImage:self.nn_fromImage
                                           toImage:self.nn_toImage
                                           process:self.nn_animationProcessing];
}

- (void)setNn_animating:(BOOL)nn_animating {
    
    if (nn_animating == true &&
        self.nn_displayLink == nil &&
        self.nn_animationDuration != 0 &&
        self.nn_frameDuration != 0) {
        CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(transitionImage)];
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

- (void)transitionImage {
    
    if (self.nn_animationProcessing >= 1.0f) {
        self.nn_animating = false;
        self.nn_animationProcessing = 1.0f;
        return;
    }
    if (self.nn_animationProcessing < 0.0f) {
        self.nn_animating = false;
        self.nn_animationProcessing = 0.0f;
        return;
    }
    
    self.nn_frameTimeCount += self.nn_displayLink.duration;
    if (self.nn_frameTimeCount < self.nn_frameDuration) {
        return;
    }
    
    CGFloat deltaProcess = self.nn_frameTimeCount / self.nn_animationDuration;
    self.nn_animationProcessing += (self.nn_isReversed ? (-deltaProcess) : deltaProcess);
    self.nn_frameTimeCount = 0.0;
    
    self.image = [UIImage imageTransitionFromImage:self.nn_fromImage
                                           toImage:self.nn_toImage
                                           process:self.nn_animationProcessing];
}

@end
