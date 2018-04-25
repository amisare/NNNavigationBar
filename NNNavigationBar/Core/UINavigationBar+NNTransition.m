//
//  UINavigationBar+NNTransition.m
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/20.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "UINavigationBar+NNTransition.h"
#import <objc/runtime.h>

static const void *kUINavigationBar_NNTransitions = &kUINavigationBar_NNTransitions;

@implementation UINavigationBar (NNTransition)

- (NSArray<id<NNTransition>> *)nn_transitions {
    
    NSArray *nn_transitions = objc_getAssociatedObject(self, kUINavigationBar_NNTransitions);
    if (!nn_transitions) {
        nn_transitions = [NSArray arrayWithArray:[self nn_registedTransitions]];
        objc_setAssociatedObject(self, kUINavigationBar_NNTransitions, nn_transitions, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return nn_transitions;
}

- (NSArray<id<NNTransition>> *)nn_registedTransitions {
    
    NSMutableArray *transitions = [NSMutableArray new];
    size_t clazzCount = NNTransitionClassCount();
    for (size_t i = 0; i < clazzCount; i++) {
        char cClazzName[256] = {0};
        NNTransitionClassFetch(cClazzName, i);
        NSString *sClazzName = [NSString stringWithUTF8String:cClazzName];
        NSLog(@"%@", sClazzName);
        Class clazz = NSClassFromString(sClazzName);
        if (clazz) {
            [transitions addObject:[[clazz alloc] initWithNavigationBar:self]];
        }
    }
    return transitions;
}

@end
