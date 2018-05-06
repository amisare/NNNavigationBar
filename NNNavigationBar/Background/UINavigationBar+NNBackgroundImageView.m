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
#import "UINavigationBar+NNBackgroundView.h"
#import "UINavigationItem+NNBackgroundItem.h"
#import "UINavigationBar+NNBackgroundImage.h"
#import "UINavigationItem+NNBackgroundImage.h"

static const void *kUINavigationBar_NNBackgroundImageView = &kUINavigationBar_NNBackgroundImageView;

@interface _NNNavigationBarBackgroundImageView : NNFadeAnimationImageView @end
@implementation _NNNavigationBarBackgroundImageView @end

@implementation UINavigationBar (NNBackgroundImageView)

- (UIImage *)nn_backgroundImageFromItem:(UINavigationItem *)item {
    
    UIImage *backgroundImage = [item nn_imageForBackgroundAtBarPosition:self.nn_sbarPosition barMetrics:self.nn_sbarMetrics];
    return backgroundImage;
}

- (UIImage *)nn_backgroundImageFromBar:(UINavigationBar *)bar {
    
    UIImage *backgroundImage = [bar nn_imageForBackgroundAtBarPosition:self.nn_sbarPosition barMetrics:self.nn_sbarMetrics];
    return backgroundImage;
}

- (UIImage *)nn_backgroundImageFromBar:(UINavigationBar *)bar item:(UINavigationItem*)item default:(UIImage *)defaultImage {
    
    {
        UIImage *backgroundImage = [self nn_backgroundImageFromItem:item];
        if (backgroundImage) {
            return backgroundImage;
        }
    }
    {
        UIImage *backgroundImage = [self nn_backgroundImageFromBar:self];
        if (backgroundImage) {
            return backgroundImage;
        }
    }
    return defaultImage;
}

- (BOOL)nn_backgroundTranslucentFromBar:(UINavigationBar *)bar item:(UINavigationItem*)item default:(BOOL)defaultValue {
    
    if (item.nn_backgroundTranslucentTransition) {
        return true;
    }
    if (self.nn_backgroundTranslucentTransition) {
        return true;
    }
    return defaultValue;
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
