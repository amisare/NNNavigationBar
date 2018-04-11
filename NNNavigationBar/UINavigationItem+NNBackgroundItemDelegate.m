//
//  UINavigationItem+NNBackgroundItemDelegate.m
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/11.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "UINavigationItem+NNBackgroundItemDelegate.h"
#import <objc/runtime.h>

static const void *kUINavigationItem_NNBackgroundItemDelegate = &kUINavigationItem_NNBackgroundItemDelegate;

@implementation UINavigationItem (NNBackgroundItemDelegate)

- (id<UINavigationItem_NNBackgroundItemDelegate>)nn_backgroundItemDelegate {
    return objc_getAssociatedObject(self, kUINavigationItem_NNBackgroundItemDelegate);
}

- (void)setNn_backgroundItemDelegate:(id<UINavigationItem_NNBackgroundItemDelegate>)nn_backgroundItemDelegate {
    objc_setAssociatedObject(self, kUINavigationItem_NNBackgroundItemDelegate, nn_backgroundItemDelegate, OBJC_ASSOCIATION_RETAIN);
}

@end
