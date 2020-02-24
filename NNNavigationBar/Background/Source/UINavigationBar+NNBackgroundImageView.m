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
#import "NNNavigationBarBackgroundImage.h"
#import "UINavigationBar+NNCoreProperties.h"
#import "UINavigationBar+NNBackgroundView.h"
#import "UINavigationItem+NNBackgroundView.h"

static const void *kUINavigationBar_NNBackgroundImageView = &kUINavigationBar_NNBackgroundImageView;

@interface _NNNavigationBarBackgroundImageView : NNFadeAnimationImageView @end
@implementation _NNNavigationBarBackgroundImageView @end

@implementation UINavigationBar (NNBackgroundImageView)

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

- (UIImage *)nn_backgroundImageFromItem:(UINavigationItem *)item {
    
    UIImage *backgroundImage = nil;
    if (backgroundImage == nil) {
        backgroundImage = nn_imageForBackground(item, self.nn_sbarPosition, self.nn_sbarMetrics);
    }
    if (backgroundImage == nil) {
        backgroundImage = nn_imageForBackground(self, self.nn_sbarPosition, self.nn_sbarMetrics);
    }
    return backgroundImage;
}

- (BOOL)nn_backgroundTranslucentFromItem:(UINavigationItem*)item {
    
    if (item.nn_backgroundTranslucentTransition) {
        return true;
    }
    if (self.nn_backgroundTranslucentTransition) {
        return true;
    }
    return false;
}

@end
