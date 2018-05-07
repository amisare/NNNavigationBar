//
//  UINavigationBar+NNTransitionForBackgroundAlpha.m
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/20.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "UINavigationBar+NNTransitionForBackgroundAlpha.h"
#import "UINavigationBar+NNBackgroundView.h"
#import "UINavigationItem+NNBackgroundItem.h"

@interface NNBackgroundAlphaTransition()

@property (nonatomic, weak) UINavigationBar *bar;

@end

@implementation NNBackgroundAlphaTransition

+ (void)load {
    [super load];
    const char *clazz = [NSStringFromClass(self) UTF8String];
    NNTransitionClassRegister(clazz, strlen(clazz));
}

- (instancetype)initWithNavigationBar:(UINavigationBar *)bar {
    self = [super init];
    if (self) {
        self.bar = bar;
    }
    return self;
}

- (void)nn_startTransitionWithParams:(NSDictionary *)params {
    
    UINavigationItem *item = [params objectForKey:@"item"];
    NSNumber *transition = [params objectForKey:@"transition"];
    
    if (transition.boolValue) {
        [UIView animateWithDuration:0.25 animations:^{
            self.bar.nn_backgroundView.alpha = item.nn_backgroundAlpha;
        }];
    }
    else {
        self.bar.nn_backgroundView.alpha = item.nn_backgroundAlpha;
    }
}

- (void)nn_endTransitionWithParams:(NSDictionary *)params {
    UINavigationItem *item = [params objectForKey:@"item"];
    self.bar.nn_backgroundView.alpha = item.nn_backgroundAlpha;
}

- (void)nn_updateInteractiveTransitionWithParams:(NSDictionary *)params {
    
    CGFloat percentComplete = [[params objectForKey:@"percentComplete"] floatValue];
    UINavigationItem *itemWillPop = [params objectForKey:@"itemWillPop"];
    UINavigationItem *itemWillPush = [params objectForKey:@"itemWillPush"];
    
    CGFloat deltAlpha = itemWillPop.nn_backgroundAlpha - itemWillPush.nn_backgroundAlpha;
    self.bar.nn_backgroundView.alpha =itemWillPush.nn_backgroundAlpha + deltAlpha * (1.0 - percentComplete);
}

- (void)nn_endInteractiveTransitionWithParams:(NSDictionary *)params {
    
    UINavigationItem *item = [params objectForKey:@"item"];
    CGFloat transition = [[params objectForKey:@"transition"] floatValue];
    BOOL finished = [[params objectForKey:@"finished"] boolValue];
    
    NSTimeInterval duration = 0.25 * (finished ?  (1 - transition) : transition);
    
    [UIView animateWithDuration:duration animations:^{
        self.bar.nn_backgroundView.alpha = item.nn_backgroundAlpha;
    }];
}

@end
