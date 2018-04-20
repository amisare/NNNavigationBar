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
    NSMapTable *table = objc_getAssociatedObject(self, kNNBackgroundItemDelegate);
    id<NNBackgroundItemDelegate> delegate = [table objectForKey:@"kNNBackgroundItemDelegate"];
    return delegate;
}

- (void)setNn_backgroundItemDelegate:(id<NNBackgroundItemDelegate>)nn_backgroundItemDelegate {
    NSMapTable *table = [NSMapTable strongToWeakObjectsMapTable];
    [table setObject:nn_backgroundItemDelegate forKey:@"kNNBackgroundItemDelegate"];
    objc_setAssociatedObject(self, kNNBackgroundItemDelegate, table, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
