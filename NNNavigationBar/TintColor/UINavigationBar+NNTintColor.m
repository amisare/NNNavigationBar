//
//  UINavigationBar+NNTintColor.m
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/24.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "UINavigationBar+NNTintColor.h"
#import <objc/runtime.h>
#import "UINavigationBar+NNCoreProperties.h"
#import "UINavigationBar+NNTintColorDelegate.h"

static const void *kUINavigationBar_NNTintColor = &kUINavigationBar_NNTintColor;

@implementation UINavigationBar (NNTintColor)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"
- (UIColor *)nn_tintColor {
    id objc = objc_getAssociatedObject(self, kUINavigationBar_NNTintColor);
    return objc;
}

- (void)setNn_tintColor:(UIColor *)nn_tintColor {
    if (nn_tintColor == nil) {
        return;
    }
    UIColor *oldTintColor = objc_getAssociatedObject(self, kUINavigationBar_NNTintColor);
    objc_setAssociatedObject(self, kUINavigationBar_NNTintColor, nn_tintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    id<NNTintColorBarDelegate> delegate = self.nn_delegate;
    if (delegate && [delegate respondsToSelector:@selector(nn_navigationBar:tintColorChange:)]) {
        [delegate nn_navigationBar:self tintColorChange:@{@"tintColorNew" : nn_tintColor,
                                                          @"tintColorOld" : (oldTintColor ? : [NSNull null]),
                                                          }];
    }
}
#pragma clang diagnostic pop

@end
