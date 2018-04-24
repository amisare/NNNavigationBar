//
//  UINavigationBar+NNBarStyle.m
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/17.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "UINavigationBar+NNBarStyle.h"
#import <objc/runtime.h>

static const void *kUINavigationBar_NNBackgroundStylePosition = &kUINavigationBar_NNBackgroundStylePosition;
static const void *kUINavigationBar_NNBackgroundStyleMetrics = &kUINavigationBar_NNBackgroundStyleMetrics;

@implementation UINavigationBar (NNBarStyle)

- (UIBarPosition)nn_barPosition {
    UIBarPosition barPosition = [objc_getAssociatedObject(self, kUINavigationBar_NNBackgroundStylePosition) integerValue];
    return barPosition;
}

- (void)setNn_barPosition:(UIBarPosition)nn_barPosition {
    objc_setAssociatedObject(self, kUINavigationBar_NNBackgroundStylePosition, @(nn_barPosition), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIBarMetrics)nn_activeBarMetrics {
    UIBarMetrics metrics = [objc_getAssociatedObject(self, kUINavigationBar_NNBackgroundStyleMetrics) integerValue];
    return metrics;
}

- (void)setNn_activeBarMetrics:(UIBarMetrics)nn_activeBarMetrics {
    objc_setAssociatedObject(self, kUINavigationBar_NNBackgroundStyleMetrics, @(nn_activeBarMetrics), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
