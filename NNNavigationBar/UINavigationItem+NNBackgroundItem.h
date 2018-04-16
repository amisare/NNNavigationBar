//
//  UINavigationItem+NNBackgroundItem.h
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/11.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationItem (NNBackgroundItem)

@property (nonatomic, strong) UIColor *nn_backgroundColor;
@property (nonatomic, strong) UIImage *nn_backgroundImage;


/* In general, you should specify a value for the normal state to be used by other states which don't have a custom value set.
 
 Similarly, when a property is dependent on the bar metrics (on the iPhone in landscape orientation, bars have a different height from standard), be sure to specify a value for UIBarMetricsDefault.
 */

- (void)setNn_backgroundImage:(UIImage *)backgroundImage forBarPosition:(UIBarPosition)barPosition barMetrics:(UIBarMetrics)barMetrics;
- (UIImage *)nn_backgroundImageForBarPosition:(UIBarPosition)barPosition barMetrics:(UIBarMetrics)barMetrics;

/*
 Same as using UIBarPositionAny in -setNn_backgroundImage:forBarPosition:barMetrics. Resizable images will be stretched
 vertically if necessary when the navigation bar is in the position UIBarPositionTopAttached.
 */
- (void)setNn_backgroundImage:(UIImage *)backgroundImage forBarMetrics:(UIBarMetrics)barMetrics;
- (UIImage *)nn_backgroundImageForBarMetrics:(UIBarMetrics)barMetrics;


- (void)setNn_backgroundColor:(UIColor *)backgroundColor forBarPosition:(UIBarPosition)barPosition barMetrics:(UIBarMetrics)barMetrics;
- (UIColor *)nn_backgroundColorForBarPosition:(UIBarPosition)barPosition barMetrics:(UIBarMetrics)barMetrics;

- (void)setNn_backgroundColor:(UIColor *)backgroundImage forBarMetrics:(UIBarMetrics)barMetrics;
- (UIColor *)nn_backgroundColorForBarPosition:(UIBarMetrics)barMetrics;

@end
