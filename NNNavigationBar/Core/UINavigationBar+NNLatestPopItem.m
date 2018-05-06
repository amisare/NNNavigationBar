//
//  UINavigationBar+NNLatestPopItem.m
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/5/7.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "UINavigationBar+NNLatestPopItem.h"
#import <objc/runtime.h>

static const void *kUINavigationBar_NNLatestPopItem = &kUINavigationBar_NNLatestPopItem;

@implementation UINavigationBar (NNLatestPopItem)

- (UINavigationItem *)nn_latestPopItem {
    NSMapTable *table = objc_getAssociatedObject(self,kUINavigationBar_NNLatestPopItem);
    id delegate = [table objectForKey:@"kUINavigationBar_NNLatestPopItem"];
    return delegate;
}

-(void)setNn_latestPopItem:(UINavigationItem *)nn_latestPopItem {
    NSMapTable *table = [NSMapTable strongToWeakObjectsMapTable];
    [table setObject:nn_latestPopItem forKey:@"kUINavigationBar_NNLatestPopItem"];
    objc_setAssociatedObject(self, kUINavigationBar_NNLatestPopItem, table, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
