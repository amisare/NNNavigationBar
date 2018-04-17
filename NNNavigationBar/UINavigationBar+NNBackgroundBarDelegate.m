//
//  UINavigationBar+NNBackgroundBarDelegate.m
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/17.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "UINavigationBar+NNBackgroundBarDelegate.h"
#import <objc/runtime.h>

static const void *kNNBackgroundBarDelegate = &kNNBackgroundBarDelegate;

@implementation UINavigationBar (NNBackgroundBarDelegate)

- (id<NNBackgroundBarDelegate>)nn_backgroundBarDelegate {
    return objc_getAssociatedObject(self, kNNBackgroundBarDelegate);
}

- (void)setNn_backgroundBarDelegate:(id<NNBackgroundBarDelegate>)nn_backgroundBarDelegate {
    objc_setAssociatedObject(self, kNNBackgroundBarDelegate, nn_backgroundBarDelegate, OBJC_ASSOCIATION_RETAIN);
}

@end
