//
//  UINavigationBar+NNCoreProperties.m
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/5/18.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "UINavigationBar+NNCoreProperties.h"
#import <objc/runtime.h>


@implementation UINavigationBar (NNBarStyle)

static const void *kUINavigationBar_NNBackgroundStylePosition = &kUINavigationBar_NNBackgroundStylePosition;
static const void *kUINavigationBar_NNBackgroundStyleMetrics = &kUINavigationBar_NNBackgroundStyleMetrics;

- (UIBarPosition)nn_sbarPosition {
    UIBarPosition barPosition = [objc_getAssociatedObject(self, kUINavigationBar_NNBackgroundStylePosition) integerValue];
    return barPosition;
}

- (void)setNn_sbarPosition:(UIBarPosition)nn_sbarPosition {
    objc_setAssociatedObject(self, kUINavigationBar_NNBackgroundStylePosition, @(nn_sbarPosition), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIBarMetrics)nn_sbarMetrics {
    UIBarMetrics metrics = [objc_getAssociatedObject(self, kUINavigationBar_NNBackgroundStyleMetrics) integerValue];
    return metrics;
}

- (void)setNn_sbarMetrics:(UIBarMetrics)nn_sbarMetrics {
    objc_setAssociatedObject(self, kUINavigationBar_NNBackgroundStyleMetrics, @(nn_sbarMetrics), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end


@implementation UINavigationBar (NNDelegate)

static const void *kUINavigationBar_NNDelegate = &kUINavigationBar_NNDelegate;

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


@implementation UINavigationBar (NNTransition)

static const void *kUINavigationBar_NNTransitions = &kUINavigationBar_NNTransitions;

- (NSArray<id<NNNTransition>> *)nn_transitions {
    NSArray *nn_transitions = objc_getAssociatedObject(self, kUINavigationBar_NNTransitions);
    if (!nn_transitions) {
        nn_transitions =
        [NSArray arrayWithArray:[self nn_registedTransitions]];
        objc_setAssociatedObject(self, kUINavigationBar_NNTransitions, nn_transitions, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return nn_transitions;
}

- (NSArray<id<NNNTransition>> *)nn_registedTransitions {
    NSMutableArray *transitions = [NSMutableArray new];
    NSArray *transitionClazzes = NNNTransitionLoader();
    for (Class transitionClazz in transitionClazzes) {
        [transitions addObject:[[transitionClazz alloc] initWithNavigationBar:self]];
    }
    return transitions;
}

@end


@implementation UINavigationBar (NNLatestPopItem)

static const void *kUINavigationBar_NNLatestPopItem = &kUINavigationBar_NNLatestPopItem;

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
