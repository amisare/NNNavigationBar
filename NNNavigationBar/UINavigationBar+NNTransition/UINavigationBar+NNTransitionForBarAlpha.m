//
//  UINavigationBar+NNTransitionForBarAlpha.m
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/20.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "UINavigationBar+NNTransitionForBarAlpha.h"
#import "UINavigationBar+NNBackgroundView.h"
#import "UINavigationItem+NNBackgroundItem.h"
#import "UINavigationBar+NNAssistantItems.h"

@interface NNBarAlphaTransition()

@property (nonatomic, weak) UINavigationBar *bar;

@end

@implementation NNBarAlphaTransition

- (instancetype)initWithNavigationBar:(UINavigationBar *)bar {
    self = [super init];
    if (self) {
        self.bar = bar;
    }
    return self;
}

- (void)nn_startTransitionWithParams:(NSDictionary *)params {
    
    UINavigationItem *item = [params objectForKey:@"item"];
//    NSNumber *transition = [params objectForKey:@"transition"];
    CGFloat alpha = item.nn_alpha;
    NSLog(@"%s %lf", __FUNCTION__, alpha);
    [self nn_setBarAlpha:alpha];
}

- (void)nn_endTransitionWithParams:(NSDictionary *)params {
    UINavigationItem *item = [params objectForKey:@"item"];
    CGFloat alpha = item.nn_alpha;
    NSLog(@"%s %lf", __FUNCTION__, alpha);
    [self nn_setBarAlpha:alpha];
}

- (void)nn_updateInteractiveTransitionWithParams:(NSDictionary *)params {
    
    CGFloat percentComplete = [[params objectForKey:@"percentComplete"] floatValue];
    CGFloat deltAlpha = self.bar.assistantItems.lastObject.nn_alpha - self.bar.topItem.nn_alpha;
    CGFloat alpha = self.bar.topItem.nn_alpha + deltAlpha * (1.0 - percentComplete);
    [self nn_setBarAlpha:alpha];
}

- (void)nn_endInteractiveTransitionWithParams:(NSDictionary *)params {
    
    UINavigationItem *item = [params objectForKey:@"item"];
//    CGFloat transition = [[params objectForKey:@"transition"] floatValue];
//    BOOL finished = [[params objectForKey:@"finished"] boolValue];
    
    [self nn_setBarAlpha:item.nn_alpha];
}

- (void)nn_setBarAlpha:(CGFloat)alpha{
    for (UIView *view in self.bar.subviews) {
        view.alpha = alpha;
    }
}

@end
