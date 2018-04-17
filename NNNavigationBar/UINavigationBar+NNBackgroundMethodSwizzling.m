//
//  UINavigationBar+NNBackgroundMethodSwizzling.m
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/17.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "UINavigationBar+NNBackgroundMethodSwizzling.h"
#import <objc/runtime.h>
#import "UIImage+NNImageWithColor.h"
#import "UINavigationBar+NNBackgroundView.h"
#import "UINavigationBar+NNBackgroundImageView.h"
#import "UINavigationBar+NNBackgroundDelegateImp.h"
#import "UINavigationItem+NNBackgroundItem.h"
#import "UINavigationItem+NNBackgroundItemDelegate.h"
#import "UINavigationBar+NNBackgroundStyle.h"

#if DEBUG
#define NN_NSLog(format, ...)      {NSLog((@"[Line %04d] %s " format), __LINE__, __PRETTY_FUNCTION__, ##__VA_ARGS__);}
#else
#define NN_NSLog(format, ...)
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

@implementation UINavigationBar (NNBackgroundMethodSwizzling)

+ (void)load {
    
    [super load];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
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
                       @selector(_completePushOperationAnimated:transitionAssistant:),
                       @selector(_nn_completePushOperationAnimated:transitionAssistant:)
                       );
    nn_swizzleSelector(self,
                       @selector(_popNavigationItemWithTransition:),
                       @selector(_nn_popNavigationItemWithTransition:)
                       );
    nn_swizzleSelector(self,
                       @selector(_completePopOperationAnimated:transitionAssistant:),
                       @selector(_nn_completePopOperationAnimated:transitionAssistant:)
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
#pragma clang diagnostic pop
    
}

- (UIBarPosition)_nn_barPosition {
    UIBarPosition position = [self _nn_barPosition];
    
    NN_NSLog(@"position:%ld", position);
    
    if (position != self.nn_barPosition) {
        self.nn_barPosition = position;
        self.nn_backgroundImageView.image = [self nn_backgroundImageFromNavigationBar:self];
        self.nn_backgroundDisplayImageView.image = [self nn_backgroundImageFromNavigationItem:self.topItem];
    }
    
    return position;
}

- (UIBarMetrics)_nn_activeBarMetrics {
    UIBarMetrics metrics = [self _nn_activeBarMetrics];
    
    NN_NSLog(@"metrics:%ld", metrics);
    
    if (metrics != self.nn_activeBarMetrics) {
        self.nn_activeBarMetrics = metrics;
        self.nn_backgroundImageView.image = [self nn_backgroundImageFromNavigationBar:self];
        self.nn_backgroundDisplayImageView.image = [self nn_backgroundImageFromNavigationItem:self.topItem];
    }
    
    return metrics;
}

- (void)_nn_pushNavigationItem:(UINavigationItem *)item transition:(int)transition {
    
    [self _nn_pushNavigationItem:item transition:transition];
    
    NN_NSLog(@"item:%@ transition:%d",item, transition);
    
    item.nn_backgroundItemDelegate = self;
    
    UIImage *backgroundImage = [self nn_backgroundImageFromNavigationItem:item];
    [self _nn_animateBackgroundWithImage:backgroundImage transition:transition];
}

- (void)_nn_completePushOperationAnimated:(BOOL)animated transitionAssistant:(id)assistant {
    
    [self _nn_completePushOperationAnimated:animated transitionAssistant:assistant];
    
    NN_NSLog(@"animated:%d assistant:%@",animated, assistant);
    
    UIImage *backgroundImage = [self nn_backgroundImageFromNavigationItem:self.topItem];
    self.nn_backgroundDisplayImageView.image = backgroundImage;
    self.nn_backgroundDisplayImageView.alpha = 1.0;
    self.nn_backgroundAssistantImageView.alpha = 0.0;
}

- (UINavigationItem *)_nn_popNavigationItemWithTransition:(int)transition {
    
    UINavigationItem *item = [self _nn_popNavigationItemWithTransition:transition];
    
    NN_NSLog(@"transition:%d return:%@",transition, item);
    
    UIImage *backgroundImage = [self nn_backgroundImageFromNavigationItem:self.topItem];
    [self _nn_animateBackgroundWithImage:backgroundImage transition:transition];
    
    return item;
}

- (void)_nn_completePopOperationAnimated:(BOOL)animated transitionAssistant:(id)assistant {
    
    [self _nn_completePopOperationAnimated:animated transitionAssistant:assistant];
    
    NN_NSLog(@"animated:%d assistant:%@", animated, assistant);
    
    UIImage *backgroundImage = [self nn_backgroundImageFromNavigationItem:self.topItem];
    self.nn_backgroundDisplayImageView.image = backgroundImage;
    self.nn_backgroundDisplayImageView.alpha = 1.0;
    self.nn_backgroundAssistantImageView.alpha = 0.0;
}

- (void)_nn_updateInteractiveTransition:(CGFloat)percentComplete {
    
    [self _nn_updateInteractiveTransition:percentComplete];
    
    NN_NSLog(@"percentComplete:%f", percentComplete);
    
    UIImage *backgroundImage = [self nn_backgroundImageFromNavigationItem:self.topItem];
    self.nn_backgroundAssistantImageView.image = backgroundImage;
    self.nn_backgroundDisplayImageView.alpha = 1.0 - percentComplete;
    self.nn_backgroundAssistantImageView.alpha = percentComplete;
}

- (void)_nn_cancelInteractiveTransition:(CGFloat)transition completionSpeed:(CGFloat)speed completionCurve:(double)curve {
    
    [self _nn_cancelInteractiveTransition:transition completionSpeed:speed completionCurve:curve];
    
    NN_NSLog(@"transition:%f speed:%f curve:%fl", transition, speed, curve);
    
    [UIView animateWithDuration:0.25 * transition animations:^{
        self.nn_backgroundDisplayImageView.alpha = 1.0;
        self.nn_backgroundAssistantImageView.alpha = 0.0;
    }];
}

- (void)_nn_finishInteractiveTransition:(CGFloat)transition completionSpeed:(CGFloat)speed completionCurve:(double)curve {
    
    [self _nn_finishInteractiveTransition:transition completionSpeed:speed completionCurve:curve];
    
    NN_NSLog(@"transition:%f speed:%f curve:%fl", transition, speed, curve);
    
    UIImage *backgroundImage = [self nn_backgroundImageFromNavigationItem:self.topItem];
    self.nn_backgroundDisplayImageView.image = backgroundImage;
    [UIView animateWithDuration:0.25 * (1 - transition) animations:^{
        self.nn_backgroundDisplayImageView.alpha = 0.0;
        self.nn_backgroundAssistantImageView.alpha = 1.0;
    }];
}

- (BOOL)_nn_didVisibleItemsChangeWithNewItems:(NSArray<UINavigationItem *> *)newItems oldItems:(NSArray<UINavigationItem *> *)oldItems {
    BOOL ret = [self _nn_didVisibleItemsChangeWithNewItems:newItems oldItems:oldItems];
    
    NN_NSLog(@"newItems:%@ oldItems:%@", newItems, oldItems);
    
    UIImage *backgroundImage = [self nn_backgroundImageFromNavigationItem:newItems.lastObject];
    self.nn_backgroundDisplayImageView.image = backgroundImage;
    self.nn_backgroundDisplayImageView.alpha = 1.0;
    self.nn_backgroundAssistantImageView.alpha = 0.0;
    
    return ret;
}

- (void)_nn_animateBackgroundWithImage:(UIImage *)image transition:(int)transition {
    
    self.nn_backgroundAssistantImageView.image = image;
    
    self.nn_backgroundDisplayImageView.alpha = 1.0;
    self.nn_backgroundAssistantImageView.alpha = 0.0;
    
    if (@(transition).boolValue) {
        
        // iOS 11.x +
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0) {
            [UIView animateWithDuration:0.25 animations:^{
                self.nn_backgroundDisplayImageView.alpha = 0.0;
                self.nn_backgroundAssistantImageView.alpha = 1.0;
            }];
            return;
        }
        
        // iOS 8.x - 10.x
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            [UIView animateWithDuration:0.25 animations:^{
                self.nn_backgroundDisplayImageView.alpha = 0.0;
                self.nn_backgroundAssistantImageView.alpha = 1.0;
            } completion:^(BOOL finished) {
                if (finished) {
                    self.nn_backgroundDisplayImageView.image = image;
                }
                self.nn_backgroundDisplayImageView.alpha = 1.0;
                self.nn_backgroundAssistantImageView.alpha = 0.0;
            }];
            return;
        }
    };
}

@end
