//
//  UINavigationBar+NNBackgroundView.m
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/11.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "UINavigationBar+NNBackgroundView.h"
#import <objc/runtime.h>
#import "UIImage+NNImageWithColor.h"
#import "NSLayoutConstraint+NNVisualFormat.h"
#import "UINavigationItem+NNBackgroundItemDelegate.h"

static const void *kUINavigationBar_NNBackgroundViewHidden = &kUINavigationBar_NNBackgroundViewHidden;
static const void *kUINavigationBar_NNBackgroundView = &kUINavigationBar_NNBackgroundView;
static const void *kUINavigationBar_NNBackgroundImageView = &kUINavigationBar_NNBackgroundImageView;
static const void *kUINavigationBar_NNBackgroundDisplayImageView = &kUINavigationBar_NNBackgroundDisplayImageView;
static const void *kUINavigationBar_NNBackgroundAssistantImageView = &kUINavigationBar_NNBackgroundAssistantImageView;

@interface _NNNavigationBarBackgroundView : UIImageView @end
@implementation _NNNavigationBarBackgroundView @end

@interface _NNNavigationBarBackgroundImageView : UIImageView @end
@implementation _NNNavigationBarBackgroundImageView @end

@interface _NNNavigationBarBackgroundDisplayImageView : UIImageView @end
@implementation _NNNavigationBarBackgroundDisplayImageView @end

@interface _NNNavigationBarBackgroundAssistantImageView : UIImageView @end
@implementation _NNNavigationBarBackgroundAssistantImageView @end


static inline void nn_swizzleSelector(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    if (class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


#pragma mark - NNBackgroundImageView

/**
 NNBackgroundImageView
 */
@interface UINavigationBar (NNBackgroundImageView)

- (UIImageView *)nn_backgroundDisplayImageView;
- (UIImageView *)nn_backgroundAssistantImageView;
- (UIImage *)nn_backgroundImageFromNavigationItem:(UINavigationItem *)item;

@end

@implementation UINavigationBar (NNBackgroundImageView)

- (UIImage *)nn_backgroundImageFromNavigationItem:(UINavigationItem *)item {
    
    UIImage *backgroundImage = nil;
    
    if (!backgroundImage) {
        backgroundImage = item.nn_backgroundImage;
    }
    
    if (!backgroundImage) {
        backgroundImage = [UIImage nn_imageWithColor:item.nn_backgroundColor];
    }
    
    if (!backgroundImage) {
        backgroundImage = [UIImage new];
    }
    
    return backgroundImage;
}

- (UIImageView *)nn_backgroundDisplayImageView {
    UIImageView *nn_backgroundDisplayImageView = objc_getAssociatedObject(self, kUINavigationBar_NNBackgroundDisplayImageView);
    if (!nn_backgroundDisplayImageView) {
        nn_backgroundDisplayImageView = [_NNNavigationBarBackgroundDisplayImageView new];
        nn_backgroundDisplayImageView.translatesAutoresizingMaskIntoConstraints = false;
        [nn_backgroundDisplayImageView setContentMode:UIViewContentModeScaleToFill];
        nn_backgroundDisplayImageView.image = [UIImage nn_imageWithColor:[UIColor clearColor]];
        objc_setAssociatedObject(self, kUINavigationBar_NNBackgroundDisplayImageView, nn_backgroundDisplayImageView, OBJC_ASSOCIATION_RETAIN);
    }
    return nn_backgroundDisplayImageView;
}

- (UIImageView *)nn_backgroundAssistantImageView {
    UIImageView *nn_backgroundAssistantImageView = objc_getAssociatedObject(self, kUINavigationBar_NNBackgroundAssistantImageView);
    if (!nn_backgroundAssistantImageView) {
        nn_backgroundAssistantImageView = [_NNNavigationBarBackgroundAssistantImageView new];
        nn_backgroundAssistantImageView.translatesAutoresizingMaskIntoConstraints = false;
        [nn_backgroundAssistantImageView setContentMode:UIViewContentModeScaleToFill];
        nn_backgroundAssistantImageView.image = [UIImage nn_imageWithColor:[UIColor clearColor]];
        objc_setAssociatedObject(self, kUINavigationBar_NNBackgroundAssistantImageView, nn_backgroundAssistantImageView, OBJC_ASSOCIATION_RETAIN);
    }
    return nn_backgroundAssistantImageView;
}

@end


#pragma mark - UINavigationItem_NNBackgroundItemDelegate

/**
 UINavigationItem_NNBackgroundItemDelegate
 */
@interface UINavigationBar (UINavigationItem_NNBackgroundItemDelegate) <UINavigationItem_NNBackgroundItemDelegate>

@end

@implementation UINavigationBar (UINavigationItem_NNBackgroundItemDelegate)

- (void)nn_navigationItem:(UINavigationItem *)item backgroundItemChangeForKey:(NSString *)key {
    
    if ([self.topItem isEqual:item]) {
        UIImage *backgroundImage = [self nn_backgroundImageFromNavigationItem:item];
        self.nn_backgroundDisplayImageView.image = backgroundImage;
    }
}

@end


#pragma mark - NNBackgroundView

/**
 NNBackgroundView
 */
@implementation UINavigationBar (NNBackgroundView)

- (BOOL)nn_backgroundViewHidden {
    return [objc_getAssociatedObject(self, kUINavigationBar_NNBackgroundViewHidden) boolValue];
}

- (void)setNn_backgroundViewHidden:(BOOL)nn_backgroundViewHidden {
    
    objc_setAssociatedObject(self, kUINavigationBar_NNBackgroundViewHidden, @(nn_backgroundViewHidden), OBJC_ASSOCIATION_RETAIN);
    if (!nn_backgroundViewHidden) {
        UIView *backgroundView = [self valueForKey:@"_backgroundView"];
        if (backgroundView && ![backgroundView.subviews containsObject:self.nn_backgroundView]) {
            [backgroundView addSubview:self.nn_backgroundView];
            
            NSArray<NSLayoutConstraint *> *(^makeViewConstraint)(NSDictionary *view) = ^(NSDictionary *view) {
                return [NSLayoutConstraint nn_constraintsWithVisualFormats:@[[NSString stringWithFormat:@"H:|[%@]|", view.allKeys.lastObject] ,
                                                                             [NSString stringWithFormat:@"V:|[%@]|", view.allKeys.lastObject]]
                                                                     views:view];
            };
            [NSLayoutConstraint activateConstraints:makeViewConstraint(@{@"nn_backgroundView" : self.nn_backgroundView})];
        }
    }
    else {
        [self.nn_backgroundView removeFromSuperview];
    }
}

- (UIView *)nn_backgroundView {
    
    UIView *nn_backgroundView = objc_getAssociatedObject(self, kUINavigationBar_NNBackgroundView);
    if (!nn_backgroundView) {
        nn_backgroundView = [_NNNavigationBarBackgroundView new];
        nn_backgroundView.translatesAutoresizingMaskIntoConstraints = false;
        [nn_backgroundView addSubview:self.nn_backgroundImageView];
        [nn_backgroundView addSubview:self.nn_backgroundAssistantImageView];
        [nn_backgroundView addSubview:self.nn_backgroundDisplayImageView];
        
        NSArray<NSLayoutConstraint *> *(^makeViewConstraint)(NSDictionary *view) = ^(NSDictionary *view) {
            return [NSLayoutConstraint nn_constraintsWithVisualFormats:@[[NSString stringWithFormat:@"H:|[%@]|", view.allKeys.lastObject] ,
                                                                         [NSString stringWithFormat:@"V:|[%@]|", view.allKeys.lastObject]]
                                                                 views:view];
        };
        
        [NSLayoutConstraint activateConstraints:makeViewConstraint(@{@"nn_backgroundImageView" : self.nn_backgroundImageView})];
        [NSLayoutConstraint activateConstraints:makeViewConstraint(@{@"nn_backgroundAssistantImageView" : self.nn_backgroundAssistantImageView})];
        [NSLayoutConstraint activateConstraints:makeViewConstraint(@{@"nn_backgroundDisplayImageView" : self.nn_backgroundDisplayImageView})];
        
        objc_setAssociatedObject(self, kUINavigationBar_NNBackgroundView, nn_backgroundView, OBJC_ASSOCIATION_RETAIN);
    }
    return nn_backgroundView;
}

- (UIImageView *)nn_backgroundImageView {
    UIImageView *nn_backgroundImageView = objc_getAssociatedObject(self, kUINavigationBar_NNBackgroundImageView);
    if (!nn_backgroundImageView) {
        nn_backgroundImageView = [_NNNavigationBarBackgroundImageView new];
        nn_backgroundImageView.translatesAutoresizingMaskIntoConstraints = false;
        [nn_backgroundImageView setContentMode:UIViewContentModeScaleToFill];
        nn_backgroundImageView.image = [UIImage nn_imageWithColor:[UIColor clearColor]];
        objc_setAssociatedObject(self, kUINavigationBar_NNBackgroundImageView, nn_backgroundImageView, OBJC_ASSOCIATION_RETAIN);
    }
    return nn_backgroundImageView;
}

@end



#pragma mark - NNBackgroundMethodSwizzling

/**
 NNBackgroundMethodSwizzling
 */

@interface UINavigationBar (NNBackgroundMethodSwizzling)

@end

@implementation UINavigationBar (NNBackgroundMethodSwizzling)

+ (void)load {
    
    [super load];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
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

- (void)_nn_pushNavigationItem:(UINavigationItem *)item transition:(int)transition {
    
    [self _nn_pushNavigationItem:item transition:transition];
    
    NSLog(@"%@ %s", [self class], __func__);
    NSLog(@"%@ %d",item, transition);
    
    item.nn_backgroundItemDelegate = self;
    
    UIImage *backgroundImage = [self nn_backgroundImageFromNavigationItem:item];
    [self _nn_animateBackgroundWithImage:backgroundImage transition:transition];
}

- (void)_nn_completePushOperationAnimated:(BOOL)animated transitionAssistant:(id)assistant {
    
    [self _nn_completePushOperationAnimated:animated transitionAssistant:assistant];
    
    NSLog(@"%@ %s", [self class], __func__);
    NSLog(@"%d %@",animated, assistant);
    
    UIImage *backgroundImage = [self nn_backgroundImageFromNavigationItem:self.topItem];
    self.nn_backgroundDisplayImageView.image = backgroundImage;
    self.nn_backgroundDisplayImageView.alpha = 1.0;
    self.nn_backgroundAssistantImageView.alpha = 0.0;
}

- (UINavigationItem *)_nn_popNavigationItemWithTransition:(int)transition {
    
    UINavigationItem *item = [self _nn_popNavigationItemWithTransition:transition];
    
    NSLog(@"%@ %s", [self class], __func__);
    NSLog(@"%d ret:%@",transition, item);
    
    UIImage *backgroundImage = [self nn_backgroundImageFromNavigationItem:self.topItem];
    [self _nn_animateBackgroundWithImage:backgroundImage transition:transition];
    
    return item;
}

- (void)_nn_completePopOperationAnimated:(BOOL)animated transitionAssistant:(id)assistant {
    
    [self _nn_completePopOperationAnimated:animated transitionAssistant:assistant];

    NSLog(@"%@ %s", [self class], __func__);
    NSLog(@"%d %@", animated, assistant);
    
    UIImage *backgroundImage = [self nn_backgroundImageFromNavigationItem:self.topItem];
    self.nn_backgroundDisplayImageView.image = backgroundImage;
    self.nn_backgroundDisplayImageView.alpha = 1.0;
    self.nn_backgroundAssistantImageView.alpha = 0.0;
}

- (void)_nn_updateInteractiveTransition:(CGFloat)percentComplete {
    
    [self _nn_updateInteractiveTransition:percentComplete];
    
    NSLog(@"%@ %s", [self class], __func__);
    NSLog(@"%f", percentComplete);
    
    UIImage *backgroundImage = [self nn_backgroundImageFromNavigationItem:self.topItem];
    self.nn_backgroundAssistantImageView.image = backgroundImage;
    self.nn_backgroundDisplayImageView.alpha = 1.0 - percentComplete;
    self.nn_backgroundAssistantImageView.alpha = percentComplete;
}

- (void)_nn_cancelInteractiveTransition:(CGFloat)transition completionSpeed:(CGFloat)speed completionCurve:(double)curve {
    
    [self _nn_cancelInteractiveTransition:transition completionSpeed:speed completionCurve:curve];
    
    NSLog(@"%@ %s", [self class], __func__);
    NSLog(@"%f %f %fl", transition, speed, curve);
    
    [UIView animateWithDuration:0.25 * transition animations:^{
        self.nn_backgroundDisplayImageView.alpha = 1.0;
        self.nn_backgroundAssistantImageView.alpha = 0.0;
    }];
}

- (void)_nn_finishInteractiveTransition:(CGFloat)transition completionSpeed:(CGFloat)speed completionCurve:(double)curve {
    
    [self _nn_finishInteractiveTransition:transition completionSpeed:speed completionCurve:curve];
    
    NSLog(@"%@ %s", [self class], __func__);
    NSLog(@"%f %f %fl", transition, speed, curve);
    
    UIImage *backgroundImage = [self nn_backgroundImageFromNavigationItem:self.topItem];
    self.nn_backgroundDisplayImageView.image = backgroundImage;
    [UIView animateWithDuration:0.25 * (1 - transition) animations:^{
        self.nn_backgroundDisplayImageView.alpha = 0.0;
        self.nn_backgroundAssistantImageView.alpha = 1.0;
    }];
}

- (BOOL)_nn_didVisibleItemsChangeWithNewItems:(NSArray<UINavigationItem *> *)newItems oldItems:(NSArray<UINavigationItem *> *)oldItems {
    BOOL ret = [self _nn_didVisibleItemsChangeWithNewItems:newItems oldItems:oldItems];
    
    NSLog(@"%@ %s", [self class], __func__);
    NSLog(@"%@ %@", newItems, oldItems);
    
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

