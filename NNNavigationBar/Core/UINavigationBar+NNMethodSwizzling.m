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

static inline Method class_findInstanceMethod(Class cls, ...) {
    
    Method ret = nil;
    
    unsigned int methodCount = 0;
    Method* methodList = class_copyMethodList(cls, &methodCount);
    
    for (unsigned int i = 0; i < methodCount; i++) {
        
        Method method = methodList[i];
        SEL sel = method_getName(method);
        size_t nameLength = strlen(sel_getName(sel));
        char *name = calloc(nameLength + 1, sizeof(char));
        strcpy(name, sel_getName(sel));
        
        BOOL isMatch = NO;
        
        { // match name length
            va_list ap;
            va_start (ap, cls);
            int _nameLength = 0;
            char *_name = va_arg(ap, char *);
            while (nil != _name) {
                _nameLength += strlen(_name);
                _name = va_arg(ap, char *);
            }
            va_end (ap);
            if (nameLength != _nameLength) {
                goto endMatch;
            }
        }
        
        { // match name chars
            va_list ap;
            va_start (ap, cls);
            char *s2_name = va_arg(ap, char *);
            size_t nameIndex = 0;
            while (nil != s2_name) {
                char *s1_name = &(name[nameIndex]);
                if (strlen(s1_name) < strlen(s2_name)) {
                    va_end (ap);
                    goto endMatch;
                }
                if (0 != memcmp(s1_name, s2_name, strlen(s2_name))) {
                    va_end (ap);
                    goto endMatch;
                }
                nameIndex += strlen(s2_name);
                s2_name = va_arg(ap, char *);
            }
            isMatch = YES;
            va_end (ap);
        }
        
    endMatch:
        free(name);
        if (isMatch == NO) {
            continue;
        }
        else {
            ret = method;
            break;
        }
    }
    free(methodList);
    
    return ret;
}

static inline void nn_swizzleMethod(Method originalMethod, Method swizzledMethod) {
    if (originalMethod == nil || swizzledMethod == nil) {
        return;
    }
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

@implementation UINavigationBar (NNMethodSwizzling)

+ (void)load {
    
    [super load];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        
#define o(key)    (key)
#define s(key)    ("_s"key)
        
        static char *originalPrefix = "_";
        static char *swizzledPrefix = "_nn";
        
        if (@available(iOS 8, *)) {
            nn_swizzleMethod(class_findInstanceMethod(self, originalPrefix, o("bar"), o("Position"), nil),
                             class_findInstanceMethod(self, swizzledPrefix, s("bar"), s("Position"), nil)
                             );
            nn_swizzleMethod(class_findInstanceMethod(self, originalPrefix, o("active"), o("Bar"), o("Metrics"), nil),
                             class_findInstanceMethod(self, swizzledPrefix, s("active"), s("Bar"), s("Metrics"), nil)
                             );
            nn_swizzleMethod(class_findInstanceMethod(self, originalPrefix, o("push"), o("Navigation"), o("Item:"), o("transition:"), nil),
                             class_findInstanceMethod(self, swizzledPrefix, s("push"), s("Navigation"), s("Item:"), s("transition:"), nil)
                             );
            nn_swizzleMethod(class_findInstanceMethod(self, originalPrefix, o("pop"), o("Navigation"), o("Item"), o("With"), o("Transition:"), nil),
                             class_findInstanceMethod(self, swizzledPrefix, s("pop"), s("Navigation"), s("Item"), s("With"), s("Transition:"), nil)
                             );
            nn_swizzleMethod(class_findInstanceMethod(self, originalPrefix, o("update"), o("Interactive"), o("Transition:"), nil),
                             class_findInstanceMethod(self, swizzledPrefix, s("update"), s("Interactive"), s("Transition:"), nil)
                             );
            nn_swizzleMethod(class_findInstanceMethod(self, originalPrefix, o("cancel"), o("Interactive"), o("Transition:"), o("completion"), o("Speed:"), o("completion"), o("Curve:"), nil),
                             class_findInstanceMethod(self, swizzledPrefix, s("cancel"), s("Interactive"), s("Transition:"), s("completion"), s("Speed:"), s("completion"), s("Curve:"), nil)
                             );
            nn_swizzleMethod(class_findInstanceMethod(self, originalPrefix, o("finish"), o("Interactive"), o("Transition:"), o("completion"), o("Speed:"), o("completion"), o("Curve:"), nil),
                             class_findInstanceMethod(self, swizzledPrefix, s("finish"), s("Interactive"), s("Transition:"), s("completion"), s("Speed:"), s("completion"), s("Curve:"), nil)
                             );
            nn_swizzleMethod(class_findInstanceMethod(self, originalPrefix, o("did"), o("Visible"), o("Items"), o("Change"), o("With"), o("New"), o("Items:"), o("old"), o("Items:"), nil),
                             class_findInstanceMethod(self, swizzledPrefix, s("did"), s("Visible"), s("Items"), s("Change"), s("With"), s("New"), s("Items:"), s("old"), s("Items:"), nil)
                             );
        }
        if (@available(iOS 11, *)) {
            nn_swizzleMethod(class_findInstanceMethod(self, originalPrefix, o("complete"), o("Pop"), o("Operation"), o("Animated:"), o("transition"), o("Assistant:"), nil),
                             class_findInstanceMethod(self, swizzledPrefix, s("complete"), s("Pop"), s("Operation"), s("Animated:"), s("transition"), s("Assistant:"), nil)
                             );
            nn_swizzleMethod(class_findInstanceMethod(self, originalPrefix, o("complete"), o("Push"), o("Operation"), o("Animated:"), o("transition"), o("Assistant:"), nil),
                             class_findInstanceMethod(self, swizzledPrefix, s("complete"), s("Push"), s("Operation"), s("Animated:"), s("transition"), s("Assistant:"), nil)
                             );
        }
#pragma clang diagnostic pop
        
    });
    
}

- (UIBarPosition)_nn_sbar_sPosition {
    UIBarPosition position = [self _nn_sbar_sPosition];
    
    if (position != self.nn_sbarPosition) {
        NNLogInfo(@"position:%ld", (long)position);
        
        self.nn_sbarPosition = position;
        for (id<NNTransition> transition in self.nn_transitions) {
            if ([transition respondsToSelector:@selector(nn_updateBarStyleTransitionWithParams:)]) {
                [transition nn_updateBarStyleTransitionWithParams:@{@"barPosition" : @(position),
                                                                    @"barMetrics" : @(self.nn_sbarMetrics)
                                                                    }];
            }
        }
    }
    
    return position;
}

- (UIBarMetrics)_nn_sactive_sBar_sMetrics {
    UIBarMetrics metrics = [self _nn_sactive_sBar_sMetrics];
    
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
    
    if (metrics != self.nn_sbarMetrics) {
        NNLogInfo(@"metrics:%ld", (long)metrics);
        
        self.nn_sbarMetrics = metrics;
        for (id<NNTransition> transition in self.nn_transitions) {
            if ([transition respondsToSelector:@selector(nn_updateBarStyleTransitionWithParams:)]) {
                [transition nn_updateBarStyleTransitionWithParams:@{@"barPosition" : @(self.nn_sbarPosition),
                                                                    @"barMetrics" : @(metrics)
                                                                    }];
            }
        }
    }
    
    return metrics;
}

- (void)_nn_spush_sNavigation_sItem:(UINavigationItem *)item _stransition:(int)transition {
    
    [self _nn_spush_sNavigation_sItem:item _stransition:transition];
    NNLogInfo(@"item:%@ transition:%d",item, transition);
    
    item.nn_delegate = self;
    [self.nn_transitions makeObjectsPerformSelector:@selector(nn_startTransitionWithParams:)
                                         withObject:@{@"item":self.topItem, @"transition":@(transition)}];
    
    self.assistantItems = [NSMutableArray arrayWithArray:self.items];
}

- (void)_nn_scomplete_sPush_sOperation_sAnimated:(BOOL)animated _stransition_sAssistant:(id)assistant {
    
    [self _nn_scomplete_sPush_sOperation_sAnimated:animated _stransition_sAssistant:assistant];
    NNLogInfo(@"animated:%d assistant:%@",animated, assistant);
    
    [self.nn_transitions makeObjectsPerformSelector:@selector(nn_endTransitionWithParams:)
                                         withObject:@{@"item":self.topItem}];
}

- (UINavigationItem *)_nn_spop_sNavigation_sItem_sWith_sTransition:(int)transition {
    
    self.assistantItems = [NSMutableArray arrayWithArray:self.items];
    
    UINavigationItem *item = [self _nn_spop_sNavigation_sItem_sWith_sTransition:transition];
    NNLogInfo(@"transition:%d return:%@",transition, item);
    
    [self.nn_transitions makeObjectsPerformSelector:@selector(nn_startTransitionWithParams:)
                                         withObject:@{@"item":self.topItem, @"transition":@(transition)}];
    return item;
}

- (void)_nn_scomplete_sPop_sOperation_sAnimated:(BOOL)animated _stransition_sAssistant:(id)assistant {
    
    [self _nn_scomplete_sPop_sOperation_sAnimated:animated _stransition_sAssistant:assistant];
    NNLogInfo(@"animated:%d assistant:%@", animated, assistant);
    
    [self.nn_transitions makeObjectsPerformSelector:@selector(nn_endTransitionWithParams:)
                                         withObject:@{@"item":self.topItem}];
}

- (void)_nn_supdate_sInteractive_sTransition:(CGFloat)percentComplete {
    
    [self _nn_supdate_sInteractive_sTransition:percentComplete];
    NNLogInfo(@"percentComplete:%f", percentComplete);
    
    [self.nn_transitions makeObjectsPerformSelector:@selector(nn_updateInteractiveTransitionWithParams:)
                                         withObject:@{@"percentComplete" : @(percentComplete)}];
}

- (void)_nn_scancel_sInteractive_sTransition:(CGFloat)transition _scompletion_sSpeed:(CGFloat)speed _scompletion_sCurve:(double)curve {
    
    [self _nn_scancel_sInteractive_sTransition:transition _scompletion_sSpeed:speed _scompletion_sCurve:curve];
    NNLogInfo(@"transition:%f speed:%f curve:%fl", transition, speed, curve);
    
    
    [self.nn_transitions makeObjectsPerformSelector:@selector(nn_endInteractiveTransitionWithParams:)
                                         withObject:@{@"item" : self.assistantItems.lastObject,
                                                      @"transition" : @(transition),
                                                      @"finished" : @(false)
                                                      }];
}

- (void)_nn_sfinish_sInteractive_sTransition:(CGFloat)transition _scompletion_sSpeed:(CGFloat)speed _scompletion_sCurve:(double)curve {
    
    [self _nn_sfinish_sInteractive_sTransition:transition _scompletion_sSpeed:speed _scompletion_sCurve:curve];
    NNLogInfo(@"transition:%f speed:%f curve:%fl", transition, speed, curve);
    
    [self.nn_transitions makeObjectsPerformSelector:@selector(nn_endInteractiveTransitionWithParams:)
                                         withObject:@{@"item" : self.topItem,
                                                      @"transition" : @(transition),
                                                      @"finished" : @(true)
                                                      }];
}

- (BOOL)_nn_sdid_sVisible_sItems_sChange_sWith_sNew_sItems:(NSArray<UINavigationItem *> *)newItems _sold_sItems:(NSArray<UINavigationItem *> *)oldItems {
    BOOL ret = [self _nn_sdid_sVisible_sItems_sChange_sWith_sNew_sItems:newItems _sold_sItems:oldItems];
    NNLogInfo(@"newItems:%@ oldItems:%@", newItems, oldItems);
    
    
    [self.nn_transitions makeObjectsPerformSelector:@selector(nn_startTransitionWithParams:)
                                         withObject:@{@"item":newItems.lastObject, @"transition":@(true)}];
    self.assistantItems = [NSMutableArray arrayWithArray:newItems];
    return ret;
}

@end


