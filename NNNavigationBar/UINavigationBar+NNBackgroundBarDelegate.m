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
    NSMapTable *table = objc_getAssociatedObject(self,kNNBackgroundBarDelegate);
    id<NNBackgroundBarDelegate> delegate = [table objectForKey:@"kNNBackgroundBarDelegate"];
    return delegate;
}

- (void)setNn_backgroundBarDelegate:(id<NNBackgroundBarDelegate>)nn_backgroundBarDelegate {
    NSMapTable *table = [NSMapTable strongToWeakObjectsMapTable];
    [table setObject:nn_backgroundBarDelegate forKey:@"kNNBackgroundBarDelegate"];
    objc_setAssociatedObject(self, kNNBackgroundBarDelegate, table, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
