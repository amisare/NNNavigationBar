//
//  UINavigationBar+NNBackgroundImage.m
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/5/6.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "UINavigationBar+NNBackgroundImage.h"
#import "UIImage+NNImageWithColor.h"
#import "UINavigationBar+NNBackgroundView.h"

@implementation UINavigationBar (NNBackgroundImage)

- (UIImage *)nn_imageForBackgroundAtBarPosition:(UIBarPosition)barPosition barMetrics:(UIBarMetrics)barMetrics {
    
    UIImage *backgroundImage = nil;
    
    if (backgroundImage == nil) {
        backgroundImage = [self nn_backgroundImageForBarPosition:barPosition barMetrics:barMetrics];
    }
    if (backgroundImage == nil) {
        UIColor *backgroundColor = [self nn_backgroundColorForBarPosition:barPosition barMetrics:barMetrics];
        backgroundImage = backgroundColor ? [UIImage nn_imageWithColor:backgroundColor] : nil;
    }
    if (backgroundImage == nil) {
        backgroundImage = [self nn_backgroundImageForBarPosition:UIBarPositionAny barMetrics:barMetrics];
    }
    if (backgroundImage == nil) {
        UIColor *backgroundColor = [self nn_backgroundColorForBarPosition:UIBarPositionAny barMetrics:barMetrics];
        backgroundImage = backgroundColor ? [UIImage nn_imageWithColor:backgroundColor] : nil;
    }
    if (backgroundImage == nil) {
        backgroundImage = [self nn_backgroundImageForBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    if (backgroundImage == nil) {
        UIColor *backgroundColor = [self nn_backgroundColorForBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        backgroundImage = backgroundColor ? [UIImage nn_imageWithColor:backgroundColor] : nil;
    }
    
    return backgroundImage;
}

@end
