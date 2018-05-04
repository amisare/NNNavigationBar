//
//  UINavigationItem+NNBackgroundItem.h
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/11.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationItem (NNBackgroundItem)

@property (nonatomic, assign) CGFloat nn_backgroundAlpha;

@property (nonatomic, assign, getter=nn_isBackgroundTransitionAlpha) BOOL nn_backgroundTransitionAlpha;
@property (nonatomic, strong) UIColor *nn_backgroundColor;
@property (nonatomic, strong) UIImage *nn_backgroundImage;


- (void)setNn_backgroundImage:(UIImage *)backgroundImage forBarPosition:(UIBarPosition)barPosition barMetrics:(UIBarMetrics)barMetrics;
- (UIImage *)nn_backgroundImageForBarPosition:(UIBarPosition)barPosition barMetrics:(UIBarMetrics)barMetrics;

- (void)setNn_backgroundImage:(UIImage *)backgroundImage forBarMetrics:(UIBarMetrics)barMetrics;
- (UIImage *)nn_backgroundImageForBarMetrics:(UIBarMetrics)barMetrics;

- (void)setNn_backgroundColor:(UIColor *)backgroundColor forBarPosition:(UIBarPosition)barPosition barMetrics:(UIBarMetrics)barMetrics;
- (UIColor *)nn_backgroundColorForBarPosition:(UIBarPosition)barPosition barMetrics:(UIBarMetrics)barMetrics;

- (void)setNn_backgroundColor:(UIColor *)backgroundColor forBarMetrics:(UIBarMetrics)barMetrics;
- (UIColor *)nn_backgroundColorForBarPosition:(UIBarMetrics)barMetrics;

@end
