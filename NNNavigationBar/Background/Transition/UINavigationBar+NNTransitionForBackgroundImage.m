//
//  UINavigationBar+NNTransitionForBackgroundImage.m
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/20.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "UINavigationBar+NNTransitionForBackgroundImage.h"
#import "UINavigationBar+NNBackgroundImageView.h"
#import "UINavigationBar+NNAssistantItems.h"

@interface NNBackgroundImageTransition()

@property (nonatomic, weak) UINavigationBar *bar;

@end

@implementation NNBackgroundImageTransition

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
    
    NSUInteger itemIndex = [self.bar.items indexOfObject:item];
    UIImage *backgroundImage = [self.bar nn_backgroundImageFromItemAtIndex:itemIndex];

    self.bar.nn_backgroundImageView.nn_fromImage = self.bar.nn_backgroundImageView.image;
    self.bar.nn_backgroundImageView.nn_toImage = backgroundImage;
    self.bar.nn_backgroundImageView.nn_reversed = false;
    self.bar.nn_backgroundImageView.nn_animationDuration = 0.25;
    self.bar.nn_backgroundImageView.nn_animationProcess = .0f;
    self.bar.nn_backgroundImageView.nn_animating = transition.boolValue;
}

- (void)nn_endTransitionWithParams:(NSDictionary *)params {
    
    UINavigationItem *item = [params objectForKey:@"item"];
    UIImage *backgroundImage = [self.bar nn_backgroundImageFromItem:item];
//    self.bar.nn_backgroundDisplayImageView.image = backgroundImage;
//    self.bar.nn_backgroundDisplayImageView.alpha = 1.0;
//    self.bar.nn_backgroundAssistantImageView.alpha = 0.0;
    
    
}

- (void)nn_updateInteractiveTransitionWithParams:(NSDictionary *)params {
    
    CGFloat percentComplete = [[params objectForKey:@"percentComplete"] floatValue];
    UIImage *backgroundImage = [self.bar nn_backgroundImageFromItem:self.bar.topItem];
    self.bar.nn_backgroundImageView.nn_toImage = backgroundImage;
    self.bar.nn_backgroundImageView.nn_animationProcess = percentComplete;
    
}

- (void)nn_endInteractiveTransitionWithParams:(NSDictionary *)params {
    
    UINavigationItem *item = [params objectForKey:@"item"];
    CGFloat transition = [[params objectForKey:@"transition"] floatValue];
    BOOL finished = [[params objectForKey:@"finished"] boolValue];
    
//    UIImage *backgroundImage = [self.bar nn_backgroundImageFromItem:item];

    self.bar.nn_backgroundImageView.nn_reversed = !finished;
    self.bar.nn_backgroundImageView.nn_animationDuration = 0.25;
    self.bar.nn_backgroundImageView.nn_animationProcess = transition;
    self.bar.nn_backgroundImageView.nn_animating = true;
    
}

- (void)nn_updateBarStyleTransitionWithParams:(NSDictionary *)params {
    
    NSUInteger itemIndex = [self.bar.assistantItems indexOfObject:self.bar.topItem];
    {
        UIImage *backgroundImage = [self.bar nn_backgroundImageFromItemAtIndex:itemIndex];
        self.bar.nn_backgroundImageView.nn_fromImage = backgroundImage;
    }
}

@end


