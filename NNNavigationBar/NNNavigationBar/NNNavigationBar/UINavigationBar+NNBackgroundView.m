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

#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

static const void *kUINavigationBar_NNBackgroundViewHidden = &kUINavigationBar_NNBackgroundViewHidden;
static const void *kUINavigationBar_NNBackgroundView = &kUINavigationBar_NNBackgroundView;
static const void *kUINavigationBar_NNBackgroundImageView = &kUINavigationBar_NNBackgroundImageView;
static const void *kUINavigationBar_NNBackgroundDisplayImageView = &kUINavigationBar_NNBackgroundDisplayImageView;
static const void *kUINavigationBar_NNBackgroundAssistantImageView = &kUINavigationBar_NNBackgroundAssistantImageView;

@interface _NNNavigationBarBackgroundImageView : UIImageView @end
@implementation _NNNavigationBarBackgroundImageView @end

@interface _NNNavigationBarBackgroundDisplayImageView : UIImageView @end
@implementation _NNNavigationBarBackgroundDisplayImageView @end

@interface _NNNavigationBarBackgroundAssistantImageView : UIImageView @end
@implementation _NNNavigationBarBackgroundAssistantImageView @end


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
    
    if (!item.nn_backgroundImage && !item.nn_backgroundColor) {
        return nil;
    }
    
    UIImage *backgroundImage = nil;
    
    if (!backgroundImage) {
        backgroundImage = item.nn_backgroundImage;
    }
    
    if (!backgroundImage) {
        backgroundImage = [UIImage nn_imageWithColor:item.nn_backgroundColor];
    }
    
    return backgroundImage;
}

- (UIImageView *)nn_backgroundDisplayImageView {
    UIImageView *nn_backgroundDisplayImageView = objc_getAssociatedObject(self, kUINavigationBar_NNBackgroundDisplayImageView);
    if (!nn_backgroundDisplayImageView) {
        nn_backgroundDisplayImageView = [_NNNavigationBarBackgroundDisplayImageView new];
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
        [nn_backgroundAssistantImageView setContentMode:UIViewContentModeScaleToFill];
        nn_backgroundAssistantImageView.image = [UIImage nn_imageWithColor:[UIColor clearColor]];
        objc_setAssociatedObject(self, kUINavigationBar_NNBackgroundAssistantImageView, nn_backgroundAssistantImageView, OBJC_ASSOCIATION_RETAIN);
    }
    return nn_backgroundAssistantImageView;
}

@end


/**
 UINavigationItem_NNBackgroundItemDelegate
 */
@interface UINavigationBar (UINavigationItem_NNBackgroundItemDelegate) <UINavigationItem_NNBackgroundItemDelegate>

@end

@implementation UINavigationBar (UINavigationItem_NNBackgroundItemDelegate)

- (void)nn_navigationItem:(UINavigationItem *)item backgroundItemChangeForKey:(NSString *)key {
    
    if ([self.topItem isEqual:item]) {
        UIImage *backgroundImage = [self nn_backgroundImageFromNavigationItem:item];
        if (!backgroundImage) {
            return;
        }
        self.nn_backgroundDisplayImageView.image = backgroundImage;
    }
}

@end


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
        if (backgroundView) {
            [backgroundView addSubview:self.nn_backgroundView];
        }
    }
    else {
        [self.nn_backgroundView removeFromSuperview];
    }
}

- (UIView *)nn_backgroundView {
    
    UIView *nn_backgroundView = objc_getAssociatedObject(self, kUINavigationBar_NNBackgroundView);
    if (!nn_backgroundView) {
        nn_backgroundView = [UIView new];
        nn_backgroundView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, iPhoneX ? 88 : 64);
        [nn_backgroundView addSubview:self.nn_backgroundImageView];
        self.nn_backgroundImageView.frame = nn_backgroundView.bounds;
        [nn_backgroundView addSubview:self.nn_backgroundAssistantImageView];
        self.nn_backgroundAssistantImageView.frame = nn_backgroundView.bounds;
        [nn_backgroundView addSubview:self.nn_backgroundDisplayImageView];
        self.nn_backgroundDisplayImageView.frame = nn_backgroundView.bounds;
        objc_setAssociatedObject(self, kUINavigationBar_NNBackgroundView, nn_backgroundView, OBJC_ASSOCIATION_RETAIN);
    }
    return nn_backgroundView;
}

- (UIImageView *)nn_backgroundImageView {
    UIImageView *nn_backgroundImageView = objc_getAssociatedObject(self, kUINavigationBar_NNBackgroundImageView);
    if (!nn_backgroundImageView) {
        nn_backgroundImageView = [_NNNavigationBarBackgroundImageView new];
        [nn_backgroundImageView setContentMode:UIViewContentModeScaleToFill];
        nn_backgroundImageView.image = [UIImage nn_imageWithColor:[UIColor clearColor]];
        objc_setAssociatedObject(self, kUINavigationBar_NNBackgroundImageView, nn_backgroundImageView, OBJC_ASSOCIATION_RETAIN);
    }
    return nn_backgroundImageView;
}

@end


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
    [self _nn_exchangeImplementationFromSelector:@selector(_pushNavigationItem:transition:)
                                      toSelector:@selector(_nn_pushNavigationItem:transition:)];
    
    [self _nn_exchangeImplementationFromSelector:@selector(_completePushOperationAnimated:transitionAssistant:)
                                      toSelector:@selector(_nn_completePushOperationAnimated:transitionAssistant:)];
    
    [self _nn_exchangeImplementationFromSelector:@selector(_popNavigationItemWithTransition:)
                                      toSelector:@selector(_nn_popNavigationItemWithTransition:)];
    
    [self _nn_exchangeImplementationFromSelector:@selector(_completePopOperationAnimated:transitionAssistant:)
                                      toSelector:@selector(_nn_completePopOperationAnimated:transitionAssistant:)];
    
    [self _nn_exchangeImplementationFromSelector:@selector(_updateInteractiveTransition:)
                                      toSelector:@selector(_nn_updateInteractiveTransition:)];
    
    [self _nn_exchangeImplementationFromSelector:@selector(_cancelInteractiveTransition:completionSpeed:completionCurve:)
                                      toSelector:@selector(_nn_cancelInteractiveTransition:completionSpeed:completionCurve:)];
    
    [self _nn_exchangeImplementationFromSelector:@selector(_finishInteractiveTransition:completionSpeed:completionCurve:)
                                      toSelector:@selector(_nn_finishInteractiveTransition:completionSpeed:completionCurve:)];
#pragma clang diagnostic pop
    
}

+ (void)_nn_exchangeImplementationFromSelector:(SEL)fromSelector toSelector:(SEL)toSelector {
    Method fromMethod = class_getInstanceMethod([UINavigationBar class], fromSelector);
    Method toMethod = class_getInstanceMethod([UINavigationBar class], toSelector);
    
    if (!class_addMethod([self class], fromSelector, method_getImplementation(toMethod), method_getTypeEncoding(toMethod))) {
        method_exchangeImplementations(fromMethod, toMethod);
    }
}


- (void)_nn_pushNavigationItem:(UINavigationItem *)item transition:(int)transition {
    
    [self _nn_pushNavigationItem:item transition:transition];
    
    NSLog(@"%@ %s:%@ %d",[self class], __func__, item, transition);
    
    item.nn_backgroundItemDelegate = self;
    
    UIImage *backgroundImage = [self nn_backgroundImageFromNavigationItem:item];
    
    if (!backgroundImage) {
        return;
    }
    
    self.nn_backgroundAssistantImageView.image = backgroundImage;
    
    self.nn_backgroundDisplayImageView.alpha = 1.0;
    self.nn_backgroundAssistantImageView.alpha = 0.0;
    if (@(transition).boolValue) {
        [UIView animateWithDuration:0.25 animations:^{
            self.nn_backgroundDisplayImageView.alpha = 0.0;
            self.nn_backgroundAssistantImageView.alpha = 1.0;
        }];
    }
}

- (void)_nn_completePushOperationAnimated:(BOOL)animated transitionAssistant:(id)assistant {
    
    [self _nn_completePushOperationAnimated:animated transitionAssistant:assistant];
    
    NSLog(@"%@ %s:%d %@",[self class], __func__, animated, assistant);
    
    UIImage *backgroundImage = [self nn_backgroundImageFromNavigationItem:self.topItem];
    
    if (!backgroundImage) {
        return;
    }
    
    self.nn_backgroundDisplayImageView.image = backgroundImage;
    self.nn_backgroundDisplayImageView.alpha = 1.0;
    self.nn_backgroundAssistantImageView.alpha = 0.0;
}

- (UINavigationItem *)_nn_popNavigationItemWithTransition:(int)transition {
    
    UINavigationItem *item = [self _nn_popNavigationItemWithTransition:transition];
    
    NSLog(@"%@ %s:%d ret:%@",[self class], __func__, transition, item);
    
    UIImage *backgroundImage = [self nn_backgroundImageFromNavigationItem:self.topItem];
    
    if (!backgroundImage) {
        return item;
    }
    
    self.nn_backgroundAssistantImageView.image = backgroundImage;
    
    self.nn_backgroundDisplayImageView.alpha = 1.0;
    self.nn_backgroundAssistantImageView.alpha = 0.0;
    
    if (@(transition).boolValue) {
        [UIView animateWithDuration:0.25 animations:^{
            self.nn_backgroundDisplayImageView.alpha = 0.0;
            self.nn_backgroundAssistantImageView.alpha = 1.0;
        }];
    };
    
    return item;
}

- (void)_nn_completePopOperationAnimated:(BOOL)animated transitionAssistant:(id)assistant {
    
    [self _nn_completePopOperationAnimated:animated transitionAssistant:assistant];
    
    NSLog(@"%@ %s:%d %@",[self class], __func__, animated, assistant);
    
    UIImage *backgroundImage = [self nn_backgroundImageFromNavigationItem:self.topItem];
    
    if (!backgroundImage) {
        return;
    }
    
    self.nn_backgroundDisplayImageView.image = backgroundImage;
    self.nn_backgroundDisplayImageView.alpha = 1.0;
    self.nn_backgroundAssistantImageView.alpha = 0.0;
}

- (void)_nn_updateInteractiveTransition:(CGFloat)percentComplete {
    
    [self _nn_updateInteractiveTransition:percentComplete];
    
    NSLog(@"%@ %s:%f",[self class], __func__, percentComplete);
    
    UIImage *backgroundImage = [self nn_backgroundImageFromNavigationItem:self.topItem];
    
    if (!backgroundImage) {
        return;
    }
    
    self.nn_backgroundAssistantImageView.image = backgroundImage;
    self.nn_backgroundDisplayImageView.alpha = 1.0 - percentComplete;
    self.nn_backgroundAssistantImageView.alpha = percentComplete;
}

- (void)_nn_cancelInteractiveTransition:(CGFloat)transition completionSpeed:(CGFloat)speed completionCurve:(double)curve {
    
    [self _nn_cancelInteractiveTransition:transition completionSpeed:speed completionCurve:curve];
    
    NSLog(@"%@ %s:%f %f %fl",[self class], __func__, transition, speed, curve);
    
    [UIView animateWithDuration:0.25 * transition animations:^{
        self.nn_backgroundDisplayImageView.alpha = 1.0;
        self.nn_backgroundAssistantImageView.alpha = 0.0;
    }];
}

- (void)_nn_finishInteractiveTransition:(CGFloat)transition completionSpeed:(CGFloat)speed completionCurve:(double)curve {
    
    [self _nn_finishInteractiveTransition:transition completionSpeed:speed completionCurve:curve];
    
    NSLog(@"%@ %s:%f %f %fl",[self class], __func__, transition, speed, curve);
    
    [UIView animateWithDuration:0.25 * (1 - transition) animations:^{
        self.nn_backgroundDisplayImageView.alpha = 0.0;
        self.nn_backgroundAssistantImageView.alpha = 1.0;
    }];
}

@end

