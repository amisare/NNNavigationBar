//
//  UINavigationBar+NNBackgroundBarDelegate.m
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/17.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "UINavigationBar+NNBackgroundBarDelegate.h"
#import <objc/runtime.h>

static const void *kUINavigationBar_NNBackgroundBarDelegate = &kUINavigationBar_NNBackgroundBarDelegate;

@implementation UINavigationBar (NNBackgroundBarDelegate)

- (id<UINavigationBar_NNBackgroundBarDelegate>)nn_backgroundBarDelegate {
    return objc_getAssociatedObject(self, kUINavigationBar_NNBackgroundBarDelegate);
}

- (void)setNn_backgroundBarDelegate:(id<UINavigationBar_NNBackgroundBarDelegate>)nn_backgroundBarDelegate {
    objc_setAssociatedObject(self, kUINavigationBar_NNBackgroundBarDelegate, nn_backgroundBarDelegate, OBJC_ASSOCIATION_RETAIN);
}

@end
