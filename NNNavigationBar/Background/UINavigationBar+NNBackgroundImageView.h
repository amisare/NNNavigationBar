//
//  UINavigationBar+NNBackgroundImageView.h
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/17.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NNFadeAnimationImageView.h"

@interface UINavigationBar (NNBackgroundImageView)

- (NNFadeAnimationImageView *)nn_backgroundImageView;
- (UIImage *)nn_backgroundImageFromBar:(UINavigationBar *)bar;
- (UIImage *)nn_backgroundImageFromItem:(UINavigationItem *)item;
- (UIImage *)nn_backgroundImageFromItemAtIndex:(NSUInteger)index;
- (BOOL)nn_backgroundTranslucentFromItemAtIndex:(NSUInteger)index;

@end
