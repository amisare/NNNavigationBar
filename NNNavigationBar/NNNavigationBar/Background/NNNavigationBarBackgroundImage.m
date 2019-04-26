//
//  NNNavigationBarBackgroundImage.m
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/5/18.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "NNNavigationBarBackgroundImage.h"
#import "UIImage+NNImageWithColor.h"

UIImage *nn_imageForBackground(id<NNNavigationBarBackgroundView> obj, UIBarPosition barPosition, UIBarMetrics barMetrics) {
    
    UIImage *backgroundImage = nil;
    
    if (backgroundImage == nil) {
        backgroundImage = [obj nn_backgroundImageForBarPosition:barPosition barMetrics:barMetrics];
    }
    if (backgroundImage == nil) {
        UIColor *backgroundColor = [obj nn_backgroundColorForBarPosition:barPosition barMetrics:barMetrics];
        backgroundImage = backgroundColor ? [UIImage nn_imageWithColor:backgroundColor] : nil;
    }
    if (backgroundImage == nil) {
        backgroundImage = [obj nn_backgroundImageForBarPosition:UIBarPositionAny barMetrics:barMetrics];
    }
    if (backgroundImage == nil) {
        UIColor *backgroundColor = [obj nn_backgroundColorForBarPosition:UIBarPositionAny barMetrics:barMetrics];
        backgroundImage = backgroundColor ? [UIImage nn_imageWithColor:backgroundColor] : nil;
    }
    if (backgroundImage == nil) {
        backgroundImage = [obj nn_backgroundImageForBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    if (backgroundImage == nil) {
        UIColor *backgroundColor = [obj nn_backgroundColorForBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        backgroundImage = backgroundColor ? [UIImage nn_imageWithColor:backgroundColor] : nil;
    }
    
    return backgroundImage;
}
