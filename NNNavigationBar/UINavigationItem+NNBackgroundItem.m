//
//  UINavigationItem+NNBackgroundItem.m
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/11.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "UINavigationItem+NNBackgroundItem.h"
#import <objc/runtime.h>
#import "UINavigationItem+NNBackgroundItemDelegate.h"

static const void *kUINavigationItem_NNBackgroundColor = &kUINavigationItem_NNBackgroundColor;
static const void *kUINavigationItem_NNBackgroundImage = &kUINavigationItem_NNBackgroundImage;

@implementation UINavigationItem (NNBackgroundItem)

- (UIColor *)nn_backgroundColor {
    return objc_getAssociatedObject(self, kUINavigationItem_NNBackgroundColor);
}

- (void)setNn_backgroundColor:(UIColor *)nn_backgroundColor {
    objc_setAssociatedObject(self, kUINavigationItem_NNBackgroundColor, nn_backgroundColor, OBJC_ASSOCIATION_RETAIN);
    if (self.nn_backgroundItemDelegate &&
        [self.nn_backgroundItemDelegate respondsToSelector:@selector(nn_navigationItem:backgroundItemChangeForKey:)]) {
        [self.nn_backgroundItemDelegate nn_navigationItem:self backgroundItemChangeForKey:@"nn_backgroundColor"];
    }
}

- (UIImage *)nn_backgroundImage {
    return objc_getAssociatedObject(self, kUINavigationItem_NNBackgroundImage);
}

- (void)setNn_backgroundImage:(UIImage *)nn_backgroundImage {
    objc_setAssociatedObject(self, kUINavigationItem_NNBackgroundImage, nn_backgroundImage, OBJC_ASSOCIATION_RETAIN);
    if (self.nn_backgroundItemDelegate &&
        [self.nn_backgroundItemDelegate respondsToSelector:@selector(nn_navigationItem:backgroundItemChangeForKey:)]) {
        [self.nn_backgroundItemDelegate nn_navigationItem:self backgroundItemChangeForKey:@"nn_backgroundImage"];
    }
}

@end
