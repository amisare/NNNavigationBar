//
//  UIColor+Help.h
//  NNNavigationBarDemo
//
//  Created by GuHaijun on 2018/4/12.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Help)

+ (UIColor *)color:(UIColor *)color updateAlpha:(CGFloat)alpha;
- (CGFloat)alpha;

@end
