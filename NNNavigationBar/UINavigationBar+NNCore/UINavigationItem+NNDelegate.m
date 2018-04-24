//
//  UINavigationItem+NNDelegate.m
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/11.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "UINavigationItem+NNDelegate.h"
#import <objc/runtime.h>

static const void *kUINavigationItem_NNDelegate = &kUINavigationItem_NNDelegate;

@implementation UINavigationItem (NNDelegate)

- (id)nn_delegate {
    NSMapTable *table = objc_getAssociatedObject(self, kUINavigationItem_NNDelegate);
    id delegate = [table objectForKey:@"kUINavigationItem_NNDelegate"];
    return delegate;
}

- (void)setNn_delegate:(id)nn_delegate {
    NSMapTable *table = [NSMapTable strongToWeakObjectsMapTable];
    [table setObject:nn_delegate forKey:@"kUINavigationItem_NNDelegate"];
    objc_setAssociatedObject(self, kUINavigationItem_NNDelegate, table, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
