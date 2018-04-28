//
//  UIImage+NNImageTransition.h
//  NNAnimatedImageView
//
//  Created by GuHaijun on 2018/4/27.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageTransition)

+ (UIImage *)imageTransitionFromImage:(UIImage *)fromImage toImage:(UIImage *)toImage process:(CGFloat)process;

@end
