//
//  UINavigationBar+NNBackgroundImageView.h
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/17.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (NNBackgroundImageView)

- (UIImageView *)nn_backgroundImageView;
- (UIImageView *)nn_backgroundDisplayImageView;
- (UIImageView *)nn_backgroundAssistantImageView;
- (UIImage *)nn_backgroundImageFromNavigationBar:(UINavigationBar *)bar;
- (UIImage *)nn_backgroundImageFromNavigationItem:(UINavigationItem *)item;

@end
