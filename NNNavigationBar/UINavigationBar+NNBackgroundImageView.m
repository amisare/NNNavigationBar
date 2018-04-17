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
#import "UINavigationBar+NNBackgroundView.h"
#import "UINavigationBar+NNBackgroundStyle.h"
#import "UINavigationItem+NNBackgroundItem.h"

static const void *kUINavigationBar_NNBackgroundImageView = &kUINavigationBar_NNBackgroundImageView;
static const void *kUINavigationBar_NNBackgroundDisplayImageView = &kUINavigationBar_NNBackgroundDisplayImageView;
static const void *kUINavigationBar_NNBackgroundAssistantImageView = &kUINavigationBar_NNBackgroundAssistantImageView;

@interface _NNNavigationBarBackgroundImageView : UIImageView @end
@implementation _NNNavigationBarBackgroundImageView @end

@interface _NNNavigationBarBackgroundDisplayImageView : UIImageView @end
@implementation _NNNavigationBarBackgroundDisplayImageView @end

@interface _NNNavigationBarBackgroundAssistantImageView : UIImageView @end
@implementation _NNNavigationBarBackgroundAssistantImageView @end


@implementation UINavigationBar (NNBackgroundImageView)

- (UIImage *)nn_backgroundImageFromNavigationItem:(UINavigationItem *)item {
    
    UIImage *backgroundImage = nil;
    
    if (!backgroundImage) {
        backgroundImage = [item nn_backgroundImageForBarPosition:self.nn_barPosition barMetrics:self.nn_activeBarMetrics];
    }
    
    if (!backgroundImage) {
        UIColor *backgroundColor = [item nn_backgroundColorForBarPosition:self.nn_barPosition barMetrics:self.nn_activeBarMetrics];
        backgroundImage = [UIImage nn_imageWithColor:backgroundColor];
    }
    
    if (!backgroundImage) {
        backgroundImage = [item nn_backgroundImageForBarPosition:UIBarPositionAny barMetrics:self.nn_activeBarMetrics];
    }
    
    if (!backgroundImage) {
        UIColor *backgroundColor = [item nn_backgroundColorForBarPosition:UIBarPositionAny barMetrics:self.nn_activeBarMetrics];
        backgroundImage = [UIImage nn_imageWithColor:backgroundColor];
    }
    
    if (!backgroundImage) {
        backgroundImage = [item nn_backgroundImageForBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    
    if (!backgroundImage) {
        UIColor *backgroundColor = [item nn_backgroundColorForBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        backgroundImage = [UIImage nn_imageWithColor:backgroundColor];
    }
    
    if (!backgroundImage) {
        backgroundImage = [UIImage new];
    }
    
    return backgroundImage;
}

- (UIImage *)nn_backgroundImageFromNavigationBar:(UINavigationBar *)bar {
    
    UIImage *backgroundImage = nil;
    
    if (!backgroundImage) {
        backgroundImage = [bar nn_backgroundImageForBarPosition:self.nn_barPosition barMetrics:self.nn_activeBarMetrics];
    }
    
    if (!backgroundImage) {
        UIColor *backgroundColor = [bar nn_backgroundColorForBarPosition:self.nn_barPosition barMetrics:self.nn_activeBarMetrics];
        backgroundImage = [UIImage nn_imageWithColor:backgroundColor];
    }
    
    if (!backgroundImage) {
        backgroundImage = [bar nn_backgroundImageForBarPosition:UIBarPositionAny barMetrics:self.nn_activeBarMetrics];
    }
    
    if (!backgroundImage) {
        UIColor *backgroundColor = [bar nn_backgroundColorForBarPosition:UIBarPositionAny barMetrics:self.nn_activeBarMetrics];
        backgroundImage = [UIImage nn_imageWithColor:backgroundColor];
    }
    
    if (!backgroundImage) {
        backgroundImage = [bar nn_backgroundImageForBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    
    if (!backgroundImage) {
        UIColor *backgroundColor = [bar nn_backgroundColorForBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        backgroundImage = [UIImage nn_imageWithColor:backgroundColor];
    }
    
    if (!backgroundImage) {
        backgroundImage = [UIImage new];
    }
    
    return backgroundImage;
}

- (UIImageView *)nn_backgroundImageView {
    UIImageView *nn_backgroundImageView = objc_getAssociatedObject(self, kUINavigationBar_NNBackgroundImageView);
    if (!nn_backgroundImageView) {
        nn_backgroundImageView = [_NNNavigationBarBackgroundImageView new];
        nn_backgroundImageView.translatesAutoresizingMaskIntoConstraints = false;
        [nn_backgroundImageView setContentMode:UIViewContentModeScaleToFill];
        nn_backgroundImageView.image = [UIImage nn_imageWithColor:[UIColor clearColor]];
        objc_setAssociatedObject(self, kUINavigationBar_NNBackgroundImageView, nn_backgroundImageView, OBJC_ASSOCIATION_RETAIN);
    }
    return nn_backgroundImageView;
}

- (UIImageView *)nn_backgroundDisplayImageView {
    UIImageView *nn_backgroundDisplayImageView = objc_getAssociatedObject(self, kUINavigationBar_NNBackgroundDisplayImageView);
    if (!nn_backgroundDisplayImageView) {
        nn_backgroundDisplayImageView = [_NNNavigationBarBackgroundDisplayImageView new];
        nn_backgroundDisplayImageView.translatesAutoresizingMaskIntoConstraints = false;
        [nn_backgroundDisplayImageView setContentMode:UIViewContentModeScaleToFill];
        nn_backgroundDisplayImageView.image = [UIImage nn_imageWithColor:[UIColor clearColor]];
        objc_setAssociatedObject(self, kUINavigationBar_NNBackgroundDisplayImageView, nn_backgroundDisplayImageView, OBJC_ASSOCIATION_RETAIN);
    }
    return nn_backgroundDisplayImageView;
}

- (UIImageView *)nn_backgroundAssistantImageView {
    UIImageView *nn_backgroundAssistantImageView = objc_getAssociatedObject(self, kUINavigationBar_NNBackgroundAssistantImageView);
    if (!nn_backgroundAssistantImageView) {
        nn_backgroundAssistantImageView = [_NNNavigationBarBackgroundAssistantImageView new];
        nn_backgroundAssistantImageView.translatesAutoresizingMaskIntoConstraints = false;
        [nn_backgroundAssistantImageView setContentMode:UIViewContentModeScaleToFill];
        nn_backgroundAssistantImageView.image = [UIImage nn_imageWithColor:[UIColor clearColor]];
        objc_setAssociatedObject(self, kUINavigationBar_NNBackgroundAssistantImageView, nn_backgroundAssistantImageView, OBJC_ASSOCIATION_RETAIN);
    }
    return nn_backgroundAssistantImageView;
}

@end
