//
//  UINavigationBar+NNTransition.m
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/20.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "UINavigationBar+NNTransition.h"
#import <objc/runtime.h>
#import "UINavigationBar+NNTransitionForBackgroundImage.h"
#import "UINavigationBar+NNTransitionForBackgroundAlpha.h"
#import "UINavigationBar+NNTransitionForTintColor.h"

static const void *kUINavigationBar_NNTransitions = &kUINavigationBar_NNTransitions;

@implementation UINavigationBar (NNTransition)

- (NSMutableArray<id<NNTransition>> *)nn_transitions {
    NSMutableArray *nn_transitions = objc_getAssociatedObject(self, kUINavigationBar_NNTransitions);
    if (!nn_transitions) {
        nn_transitions = [NSMutableArray new];
        [nn_transitions addObject:[[NNBackgroundImageTransition alloc] initWithNavigationBar:self]];
        [nn_transitions addObject:[[NNBackgroundViewTransition alloc] initWithNavigationBar:self]];
        [nn_transitions addObject:[[NNTintColorTransition alloc] initWithNavigationBar:self]];
        objc_setAssociatedObject(self, kUINavigationBar_NNTransitions, nn_transitions, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return nn_transitions;
}

@end
