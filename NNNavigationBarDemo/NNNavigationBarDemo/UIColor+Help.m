//
//  UIColor+Help.m
//  NNNavigationBarDemo
//
//  Created by GuHaijun on 2018/4/12.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "UIColor+Help.h"

@implementation UIColor (Help)

+ (UIColor *)color:(UIColor *)color updateAlpha:(CGFloat)alpha {
    CGFloat colors[4];
    [color getRed:&(colors[0]) green:&(colors[1]) blue:&(colors[2]) alpha:&(colors[3])];
    return [UIColor colorWithRed:colors[0] green:colors[1] blue:colors[2] alpha:alpha];
}

- (CGFloat)alpha {
    CGFloat colors[4];
    [self getRed:&(colors[0]) green:&(colors[1]) blue:&(colors[2]) alpha:&(colors[3])];
    return colors[3];
}

@end
