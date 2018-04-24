//
//  UINavigationBar+NNMethodSwizzling.m
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/17.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "UINavigationBar+NNMethodSwizzling.h"
#import <objc/runtime.h>
#import "UINavigationBar+NNTransition.h"
#import "UINavigationBar+NNBarStyle.h"
#import "UINavigationBar+NNAssistantItems.h"
#import "UINavigationItem+NNDelegate.h"

#ifdef NNNavigationBarLoggingEnable
#define NNLogInfo(format, ...)      {NSLog((@"[Line %04d] %s " format), __LINE__, __PRETTY_FUNCTION__, ##__VA_ARGS__);}
#else
#define NNLogInfo(format, ...)
#endif

static inline void nn_swizzleSelector(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    if (class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@implementation UINavigationBar (NNMethodSwizzling)

+ (void)load {
    
    [super load];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        if (@available(iOS 8, *)) {
            nn_swizzleSelector(self,
                               @selector(_barPosition),
                               @selector(_nn_barPosition)
                               );
            nn_swizzleSelector(self,
                               @selector(_activeBarMetrics),
                               @selector(_nn_activeBarMetrics)
                               );
            nn_swizzleSelector(self,
                               @selector(_pushNavigationItem:transition:),
                               @selector(_nn_pushNavigationItem:transition:)
                               );
            nn_swizzleSelector(self,
                               @selector(_popNavigationItemWithTransition:),
                               @selector(_nn_popNavigationItemWithTransition:)
                               );
            nn_swizzleSelector(self,
                               @selector(_updateInteractiveTransition:),
                               @selector(_nn_updateInteractiveTransition:)
                               );
            nn_swizzleSelector(self,
                               @selector(_cancelInteractiveTransition:completionSpeed:completionCurve:),
                               @selector(_nn_cancelInteractiveTransition:completionSpeed:completionCurve:)
                               );
            nn_swizzleSelector(self,
                               @selector(_finishInteractiveTransition:completionSpeed:completionCurve:),
                               @selector(_nn_finishInteractiveTransition:completionSpeed:completionCurve:)
                               );
            nn_swizzleSelector(self,
                               @selector(_didVisibleItemsChangeWithNewItems:oldItems:),
                               @selector(_nn_didVisibleItemsChangeWithNewItems:oldItems:)
                               );
        }
        if (@available(iOS 11, *)) {
            nn_swizzleSelector(self,
                               @selector(_completePushOperationAnimated:transitionAssistant:),
                               @selector(_nn_completePushOperationAnimated:transitionAssistant:)
                               );
            nn_swizzleSelector(self,
                               @selector(_completePopOperationAnimated:transitionAssistant:),
                               @selector(_nn_completePopOperationAnimated:transitionAssistant:)
                               );
        }
#pragma clang diagnostic pop
        
    });
    
}

- (UIBarPosition)_nn_barPosition {
    UIBarPosition position = [self _nn_barPosition];
    
    if (position != self.nn_barPosition) {
        NNLogInfo(@"position:%ld", (long)position);
        
        self.nn_barPosition = position;
        for (id<NNTransition> transition in self.nn_transitions) {
            if ([transition respondsToSelector:@selector(nn_updateBarStyleTransitionWithParams:)]) {
                [transition nn_updateBarStyleTransitionWithParams:@{@"barPosition" : @(position),
                                                                    @"barMetrics" : @(self.nn_activeBarMetrics)
                                                                    }];
            }
        }
    }
    
    return position;
}

- (UIBarMetrics)_nn_activeBarMetrics {
    UIBarMetrics metrics = [self _nn_activeBarMetrics];
    
    //fix: metrics value not change on prompt mode in iOS 11
    /*
     * The log here may be confusing to you, in the case of a screen rotation.
     * The last [self.topItem] witch UINavigatinBar got during the rotation not the current viewController's navigationItem.
     * It is a new object that helps to complete the animation. You do not need to pay attention to it and ignore the log output at this time.
     */
    if (@available(iOS 11, *)) {
        if (self.topItem.prompt != nil) {
            if (metrics == UIBarMetricsDefault) {
                metrics = UIBarMetricsDefaultPrompt;
            }
            if (metrics == UIBarMetricsCompact) {
                metrics = UIBarMetricsCompactPrompt;
            }
        }
    }
    
    if (metrics != self.nn_activeBarMetrics) {
        NNLogInfo(@"metrics:%ld", (long)metrics);
        
        self.nn_activeBarMetrics = metrics;
        for (id<NNTransition> transition in self.nn_transitions) {
            if ([transition respondsToSelector:@selector(nn_updateBarStyleTransitionWithParams:)]) {
                [transition nn_updateBarStyleTransitionWithParams:@{@"barPosition" : @(self.nn_barPosition),
                                                                    @"barMetrics" : @(metrics)
                                                                    }];
            }
        }
    }
    
    return metrics;
}

- (void)_nn_pushNavigationItem:(UINavigationItem *)item transition:(int)transition {
    
    [self _nn_pushNavigationItem:item transition:transition];
    NNLogInfo(@"item:%@ transition:%d",item, transition);
    
    item.nn_delegate = self;
    [self.nn_transitions makeObjectsPerformSelector:@selector(nn_startTransitionWithParams:)
                                         withObject:@{@"item":self.topItem, @"transition":@(transition)}];
    
    self.assistantItems = [NSMutableArray arrayWithArray:self.items];
}

- (void)_nn_completePushOperationAnimated:(BOOL)animated transitionAssistant:(id)assistant {
    
    [self _nn_completePushOperationAnimated:animated transitionAssistant:assistant];
    NNLogInfo(@"animated:%d assistant:%@",animated, assistant);
    
    [self.nn_transitions makeObjectsPerformSelector:@selector(nn_endTransitionWithParams:)
                                         withObject:@{@"item":self.topItem}];
}

- (UINavigationItem *)_nn_popNavigationItemWithTransition:(int)transition {
    
    self.assistantItems = [NSMutableArray arrayWithArray:self.items];
    
    UINavigationItem *item = [self _nn_popNavigationItemWithTransition:transition];
    NNLogInfo(@"transition:%d return:%@",transition, item);
    
    [self.nn_transitions makeObjectsPerformSelector:@selector(nn_startTransitionWithParams:)
                                         withObject:@{@"item":self.topItem, @"transition":@(transition)}];
    return item;
}

- (void)_nn_completePopOperationAnimated:(BOOL)animated transitionAssistant:(id)assistant {
    
    [self _nn_completePopOperationAnimated:animated transitionAssistant:assistant];
    NNLogInfo(@"animated:%d assistant:%@", animated, assistant);
    
    [self.nn_transitions makeObjectsPerformSelector:@selector(nn_endTransitionWithParams:)
                                         withObject:@{@"item":self.topItem}];
}

- (void)_nn_updateInteractiveTransition:(CGFloat)percentComplete {
    
    [self _nn_updateInteractiveTransition:percentComplete];
    NNLogInfo(@"percentComplete:%f", percentComplete);
    
    [self.nn_transitions makeObjectsPerformSelector:@selector(nn_updateInteractiveTransitionWithParams:)
                                         withObject:@{@"percentComplete" : @(percentComplete)}];
}

- (void)_nn_cancelInteractiveTransition:(CGFloat)transition completionSpeed:(CGFloat)speed completionCurve:(double)curve {
    
    [self _nn_cancelInteractiveTransition:transition completionSpeed:speed completionCurve:curve];
    NNLogInfo(@"transition:%f speed:%f curve:%fl", transition, speed, curve);
    
    
    [self.nn_transitions makeObjectsPerformSelector:@selector(nn_endInteractiveTransitionWithParams:)
                                         withObject:@{@"item" : self.assistantItems.lastObject,
                                                      @"transition" : @(transition),
                                                      @"finished" : @(false)
                                                      }];
}

- (void)_nn_finishInteractiveTransition:(CGFloat)transition completionSpeed:(CGFloat)speed completionCurve:(double)curve {
    
    [self _nn_finishInteractiveTransition:transition completionSpeed:speed completionCurve:curve];
    NNLogInfo(@"transition:%f speed:%f curve:%fl", transition, speed, curve);
    
    [self.nn_transitions makeObjectsPerformSelector:@selector(nn_endInteractiveTransitionWithParams:)
                                         withObject:@{@"item" : self.topItem,
                                                      @"transition" : @(transition),
                                                      @"finished" : @(true)
                                                      }];
}

- (BOOL)_nn_didVisibleItemsChangeWithNewItems:(NSArray<UINavigationItem *> *)newItems oldItems:(NSArray<UINavigationItem *> *)oldItems {
    BOOL ret = [self _nn_didVisibleItemsChangeWithNewItems:newItems oldItems:oldItems];
    NNLogInfo(@"newItems:%@ oldItems:%@", newItems, oldItems);
    
    
    [self.nn_transitions makeObjectsPerformSelector:@selector(nn_startTransitionWithParams:)
                                         withObject:@{@"item":newItems.lastObject, @"transition":@(true)}];
    self.assistantItems = [NSMutableArray arrayWithArray:newItems];
    return ret;
}

@end


