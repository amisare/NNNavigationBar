//
//  UINavigationBar+NNTransitionForTintColor.m
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/20.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "UINavigationBar+NNTransitionForTintColor.h"
#import "UINavigationBar+NNBackgroundView.h"
#import "UINavigationItem+NNBackgroundItem.h"
#import "UINavigationBar+NNAssistantItems.h"

@interface NNTintColorTransition()

@property (nonatomic, weak) UINavigationBar *bar;

@end

@implementation NNTintColorTransition

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
    self.bar.tintColor = item.nn_tintColor;
}

- (void)nn_endTransitionWithParams:(NSDictionary *)params {
    UINavigationItem *item = [params objectForKey:@"item"];
    self.bar.tintColor = item.nn_tintColor;
}

- (void)nn_updateInteractiveTransitionWithParams:(NSDictionary *)params {
    
//    CGFloat percentComplete = [[params objectForKey:@"percentComplete"] floatValue];
 
}

- (void)nn_endInteractiveTransitionWithParams:(NSDictionary *)params {
    
//    UINavigationItem *item = [params objectForKey:@"item"];
//    CGFloat transition = [[params objectForKey:@"transition"] floatValue];
//    BOOL finished = [[params objectForKey:@"item"] boolValue];
    
}

@end
