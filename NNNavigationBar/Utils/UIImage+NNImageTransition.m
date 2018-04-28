//
//  UIImage+NNImageTransition.m
//  NNAnimatedImageView
//
//  Created by GuHaijun on 2018/4/27.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "UIImage+NNImageTransition.h"

@implementation UIImage (ImageTransition)

+ (UIImage *)imageTransitionFromImage:(UIImage *)fromImage toImage:(UIImage *)toImage process:(CGFloat)process {
    
    if (fromImage == nil && toImage == nil) {
        return nil;
    }
    
    CGFloat _process = process;
    if (_process < 0.0) {
        _process = 0.0;
    }
    if (_process > 1.0) {
        _process = 1.0;
    }
    
    CGRect imageRect = CGRectMake(0, 0, fromImage.size.width, fromImage.size.height);
    
    UIGraphicsBeginImageContextWithOptions(imageRect.size, false, 0.0f);
    if (fromImage) {
        [fromImage drawInRect:imageRect blendMode:kCGBlendModeMultiply alpha:(1 - process)];
    }
    if (toImage) {
        [toImage drawInRect:imageRect blendMode:kCGBlendModeMultiply alpha:process];
    }
    UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return retImage;
}

@end
