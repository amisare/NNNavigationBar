//
//  UINavigationBar+NNDelegate.m
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/17.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "UINavigationBar+NNDelegate.h"
#import <objc/runtime.h>

static const void *kUINavigationBar_NNDelegate = &kUINavigationBar_NNDelegate;

@implementation UINavigationBar (NNDelegate)

- (id)nn_delegate {
    NSMapTable *table = objc_getAssociatedObject(self,kUINavigationBar_NNDelegate);
    id delegate = [table objectForKey:@"kUINavigationBar_NNDelegate"];
    return delegate;
}

- (void)setNn_delegate:(id)nn_delegate {
    NSMapTable *table = [NSMapTable strongToWeakObjectsMapTable];
    [table setObject:nn_delegate forKey:@"kUINavigationBar_NNDelegate"];
    objc_setAssociatedObject(self, kUINavigationBar_NNDelegate, table, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
