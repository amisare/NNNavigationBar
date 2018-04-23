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
#import "UINavigationBar+NNAssistantItems.h"

@interface NNBackgroundViewTransition()

@property (nonatomic, weak) UINavigationBar *bar;

@end

@implementation NNBackgroundViewTransition

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
    CGFloat deltAlpha = self.bar.assistantItems.lastObject.nn_backgroundAlpha - self.bar.topItem.nn_backgroundAlpha;
    self.bar.nn_backgroundView.alpha = self.bar.topItem.nn_backgroundAlpha + deltAlpha * (1.0 - percentComplete);
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
