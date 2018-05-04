//
//  UINavigationBar+NNBackgroundImageView.h
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/17.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NNAnimatedImageView.h"

@interface UINavigationBar (NNBackgroundImageView)

- (NNAnimatedImageView *)nn_backgroundImageView;
- (UIImage *)nn_backgroundImageFromBar:(UINavigationBar *)bar;
- (UIImage *)nn_backgroundImageFromItem:(UINavigationItem *)item;
- (UIImage *)nn_backgroundImageFromItemAtIndex:(NSUInteger)index;
- (BOOL)nn_backgroundTransitionAlphaFromItemAtIndex:(NSUInteger)index;

@end
