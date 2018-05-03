//
//  UINavigationBar+NNBackgroundImageView.m
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/17.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "UINavigationBar+NNBackgroundImageView.h"
#import <objc/runtime.h>
#import "UIImage+NNImageWithColor.h"
#import "UINavigationBar+NNBarStyle.h"
#import "UINavigationBar+NNAssistantItems.h"
#import "UINavigationBar+NNBackgroundView.h"
#import "UINavigationItem+NNBackgroundItem.h"

static const void *kUINavigationBar_NNBackgroundImageView = &kUINavigationBar_NNBackgroundImageView;

@interface _NNNavigationBarBackgroundImageView : NNAnimatedImageView @end
@implementation _NNNavigationBarBackgroundImageView @end

@implementation UINavigationBar (NNBackgroundImageView)

- (UIImage *)nn_backgroundImageFromItem:(UINavigationItem *)item {
    
    UIImage *backgroundImage = nil;
    
    if (backgroundImage == nil) {
        backgroundImage = [item nn_backgroundImageForBarPosition:self.nn_sbarPosition barMetrics:self.nn_sbarMetrics];
    }
    if (backgroundImage == nil) {
        UIColor *backgroundColor = [item nn_backgroundColorForBarPosition:self.nn_sbarPosition barMetrics:self.nn_sbarMetrics];
        backgroundImage = [UIImage nn_imageWithColor:backgroundColor];
    }
    if (backgroundImage == nil) {
        backgroundImage = [item nn_backgroundImageForBarPosition:UIBarPositionAny barMetrics:self.nn_sbarMetrics];
    }
    if (backgroundImage == nil) {
        UIColor *backgroundColor = [item nn_backgroundColorForBarPosition:UIBarPositionAny barMetrics:self.nn_sbarMetrics];
        backgroundImage = [UIImage nn_imageWithColor:backgroundColor];
    }
    if (backgroundImage == nil) {
        backgroundImage = [item nn_backgroundImageForBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    if (backgroundImage == nil) {
        UIColor *backgroundColor = [item nn_backgroundColorForBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        backgroundImage = [UIImage nn_imageWithColor:backgroundColor];
    }
    
    return backgroundImage;
}

- (UIImage *)nn_backgroundImageFromBar:(UINavigationBar *)bar {
    
    UIImage *backgroundImage = nil;
    
    if (backgroundImage == nil) {
        backgroundImage = [bar nn_backgroundImageForBarPosition:self.nn_sbarPosition barMetrics:self.nn_sbarMetrics];
    }
    if (backgroundImage == nil) {
        UIColor *backgroundColor = [bar nn_backgroundColorForBarPosition:self.nn_sbarPosition barMetrics:self.nn_sbarMetrics];
        backgroundImage = [UIImage nn_imageWithColor:backgroundColor];
    }
    if (backgroundImage == nil) {
        backgroundImage = [bar nn_backgroundImageForBarPosition:UIBarPositionAny barMetrics:self.nn_sbarMetrics];
    }
    if (backgroundImage == nil) {
        UIColor *backgroundColor = [bar nn_backgroundColorForBarPosition:UIBarPositionAny barMetrics:self.nn_sbarMetrics];
        backgroundImage = [UIImage nn_imageWithColor:backgroundColor];
    }
    if (backgroundImage == nil) {
        backgroundImage = [bar nn_backgroundImageForBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    if (backgroundImage == nil) {
        UIColor *backgroundColor = [bar nn_backgroundColorForBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        backgroundImage = [UIImage nn_imageWithColor:backgroundColor];
    }
    
    return backgroundImage;
}

- (UIImage *)nn_backgroundImageFromItemAtIndex:(NSUInteger)index {
    
    UINavigationItem *item = [self.assistantItems objectAtIndex:index];
    
    UIImage *backgroundImage = nil;
    if (backgroundImage == nil) {
        backgroundImage = [self nn_backgroundImageFromItem:item];
    }
    if (backgroundImage == nil) {
        backgroundImage = [self nn_backgroundImageFromBar:self];
    }
    
    return backgroundImage;
}

- (_NNNavigationBarBackgroundImageView *)nn_backgroundImageView {
    _NNNavigationBarBackgroundImageView *nn_backgroundImageView = objc_getAssociatedObject(self, kUINavigationBar_NNBackgroundImageView);
    if (!nn_backgroundImageView) {
        nn_backgroundImageView = [_NNNavigationBarBackgroundImageView new];
        nn_backgroundImageView.translatesAutoresizingMaskIntoConstraints = false;
        [nn_backgroundImageView setContentMode:UIViewContentModeScaleToFill];
        nn_backgroundImageView.nn_image = [UIImage nn_imageWithColor:[UIColor clearColor]];
        nn_backgroundImageView.nn_frameDuration = 0.016;
        objc_setAssociatedObject(self, kUINavigationBar_NNBackgroundImageView, nn_backgroundImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return nn_backgroundImageView;
}

@end
