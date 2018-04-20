//
//  UINavigationBar+NNTransitionForBackgroundImage.m
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/20.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "UINavigationBar+NNTransitionForBackgroundImage.h"
#import "UINavigationBar+NNBackgroundImageView.h"

@interface NNBackgroundImageTransition()

@property (nonatomic, weak) UINavigationBar *bar;

@end

@implementation NNBackgroundImageTransition

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
    
    UIImage *backgroundImage = [self.bar nn_backgroundImageFromItem:item];
    
    self.bar.nn_backgroundAssistantImageView.image = backgroundImage;
    self.bar.nn_backgroundDisplayImageView.alpha = 1.0;
    self.bar.nn_backgroundAssistantImageView.alpha = 0.0;
    
    if (transition.boolValue) {
        
        // iOS 11.x +
        if (@available(iOS 11, *)) {
            [UIView animateWithDuration:0.25 animations:^{
                self.bar.nn_backgroundDisplayImageView.alpha = 0.0;
                self.bar.nn_backgroundAssistantImageView.alpha = 1.0;
            }];
            return;
        }
        
        // iOS 8.x - 10.x
        if (@available(iOS 8, *)) {
            [UIView animateWithDuration:0.25 animations:^{
                self.bar.nn_backgroundDisplayImageView.alpha = 0.0;
                self.bar.nn_backgroundAssistantImageView.alpha = 1.0;
            } completion:^(BOOL finished) {
                // a new animation cause the finished to false
                if (!finished) {
                    return;
                }
                [self nn_endTransitionWithParams:@{@"item" : self.bar.topItem}];
            }];
            return;
        }
    };
}

- (void)nn_endTransitionWithParams:(NSDictionary *)params {
    
    UINavigationItem *item = [params objectForKey:@"item"];
    UIImage *backgroundImage = [self.bar nn_backgroundImageFromItem:item];
    self.bar.nn_backgroundDisplayImageView.image = backgroundImage;
    self.bar.nn_backgroundDisplayImageView.alpha = 1.0;
    self.bar.nn_backgroundAssistantImageView.alpha = 0.0;
}

- (void)nn_updateInteractiveTransitionWithParams:(NSDictionary *)params {
    
    CGFloat percentComplete = [[params objectForKey:@"percentComplete"] floatValue];
    UIImage *backgroundImage = [self.bar nn_backgroundImageFromItem:self.bar.topItem];
    self.bar.nn_backgroundAssistantImageView.image = backgroundImage;
    self.bar.nn_backgroundDisplayImageView.alpha = 1.0 - percentComplete;
    self.bar.nn_backgroundAssistantImageView.alpha = percentComplete;
}

- (void)nn_endInteractiveTransitionWithParams:(NSDictionary *)params {
    
    UINavigationItem *item = [params objectForKey:@"item"];
    CGFloat transition = [[params objectForKey:@"transition"] floatValue];
    BOOL finished = [[params objectForKey:@"finished"] boolValue];
    
    NSTimeInterval duration = 0.25 * (finished ?  (1 - transition) : transition);
    
    UIImage *backgroundImage = [self.bar nn_backgroundImageFromItem:item];
    self.bar.nn_backgroundDisplayImageView.image = backgroundImage;
    [UIView animateWithDuration:duration animations:^{
        self.bar.nn_backgroundDisplayImageView.alpha = 1.0;
        self.bar.nn_backgroundAssistantImageView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self nn_endTransitionWithParams:@{@"item" : item}];
    }];
}

@end


