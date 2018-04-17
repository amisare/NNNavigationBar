//
//  UINavigationItem+NNBackgroundItemDelegate.m
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/11.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "UINavigationItem+NNBackgroundItemDelegate.h"
#import <objc/runtime.h>

static const void *kNNBackgroundItemDelegate = &kNNBackgroundItemDelegate;

@implementation UINavigationItem (NNBackgroundItemDelegate)

- (id<NNBackgroundItemDelegate>)nn_backgroundItemDelegate {
    return objc_getAssociatedObject(self, kNNBackgroundItemDelegate);
}

- (void)setNn_backgroundItemDelegate:(id<NNBackgroundItemDelegate>)nn_backgroundItemDelegate {
    objc_setAssociatedObject(self, kNNBackgroundItemDelegate, nn_backgroundItemDelegate, OBJC_ASSOCIATION_RETAIN);
}

@end
