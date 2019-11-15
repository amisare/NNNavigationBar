//
//  NNBackgroundImageTransition.m
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/20.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "NNBackgroundImageTransition.h"
#import "UINavigationBar+NNBackgroundImageView.h"

@nn_transition(NNBackgroundImageTransition)
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
    BOOL isBackgroundTranslucent = [self.bar nn_backgroundTranslucentFromItem:item];

    self.bar.nn_backgroundImageView.nn_toImage = backgroundImage;
    self.bar.nn_backgroundImageView.nn_hasAnimation = transition.boolValue;
    self.bar.nn_backgroundImageView.nn_hasTranslucentEffect = isBackgroundTranslucent;
    self.bar.nn_backgroundImageView.nn_reversed = false;
    self.bar.nn_backgroundImageView.nn_animationDuration = 0.25;
    self.bar.nn_backgroundImageView.nn_animationProcess = .0f;
    self.bar.nn_backgroundImageView.nn_animationState = NNFadeAnimationStateStart;
}

- (void)nn_endTransitionWithParams:(NSDictionary *)params {
    
}

- (void)nn_updateInteractiveTransitionWithParams:(NSDictionary *)params {
    
    CGFloat percentComplete = [[params objectForKey:@"percentComplete"] floatValue];
    UINavigationItem *itemWillAppear = [params objectForKey:@"itemWillAppear"];
    
    UIImage *backgroundImage = [self.bar nn_backgroundImageFromItem:itemWillAppear];
    self.bar.nn_backgroundImageView.nn_toImage = backgroundImage;
    self.bar.nn_backgroundImageView.nn_animationProcess = percentComplete;
}

- (void)nn_endInteractiveTransitionWithParams:(NSDictionary *)params {
    
    CGFloat transition = [[params objectForKey:@"transition"] floatValue];
    BOOL finished = [[params objectForKey:@"finished"] boolValue];
    
    self.bar.nn_backgroundImageView.nn_reversed = !finished;
    self.bar.nn_backgroundImageView.nn_animationDuration = 0.25;
    self.bar.nn_backgroundImageView.nn_animationProcess = transition;
    self.bar.nn_backgroundImageView.nn_animationState = NNFadeAnimationStateStart;
}

- (void)nn_updateBarStyleTransitionWithParams:(NSDictionary *)params {

    UIImage *backgroundImage = [self.bar nn_backgroundImageFromItem:self.bar.topItem];
    self.bar.nn_backgroundImageView.nn_image = backgroundImage;
}

@end


