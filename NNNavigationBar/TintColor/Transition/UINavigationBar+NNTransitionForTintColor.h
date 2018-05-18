//
//  UINavigationBar+NNTransitionForTintColor.h
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/20.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationBar+NNCoreProperties.h"

@interface NNTintColorTransition : NSObject <NNTransition>

- (instancetype)initWithNavigationBar:(UINavigationBar *)bar;
- (void)nn_startTransitionWithParams:(NSDictionary *)params;
- (void)nn_endTransitionWithParams:(NSDictionary *)params;
- (void)nn_updateInteractiveTransitionWithParams:(NSDictionary *)params;
- (void)nn_endInteractiveTransitionWithParams:(NSDictionary *)params;

@end
