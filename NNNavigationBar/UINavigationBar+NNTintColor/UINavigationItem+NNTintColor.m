//
//  UINavigationItem+NNTintColor.m
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/24.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "UINavigationItem+NNTintColor.h"
#import <objc/runtime.h>
#import "UINavigationItem+NNDelegate.h"
#import "UINavigationItem+NNTintColorDelegate.h"

static const void *kUINavigationItem_NNTintColor = &kUINavigationItem_NNTintColor;

@implementation UINavigationItem (NNTintColor)

- (UIColor *)nn_tintColor {
    id objc = objc_getAssociatedObject(self, kUINavigationItem_NNTintColor);
    return objc;
}

- (void)setNn_tintColor:(UIColor *)nn_tintColor {
    if (nn_tintColor == nil) {
        return;
    }
    UIColor *oldTintColor = objc_getAssociatedObject(self, kUINavigationItem_NNTintColor);
    objc_setAssociatedObject(self, kUINavigationItem_NNTintColor, nn_tintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    id<NNTintColorItemDelegate> delegate = self.nn_delegate;
    if (delegate && [delegate respondsToSelector:@selector(nn_navigationItem:tintColorChange:)]) {
        [delegate nn_navigationItem:self tintColorChange:@{@"tintColorNew" : nn_tintColor,
                                                           @"tintColorOld" : (oldTintColor ? : [NSNull null]),
                                                           }];
    }
}

@end
