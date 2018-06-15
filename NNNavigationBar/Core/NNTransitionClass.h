//
//  NNTransitionClass.h
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/5/18.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import <UIKit/UIKit.h>

int NNTransitionClassRegister(const char *clazz, size_t length);
size_t NNTransitionClassCount(void);
int NNTransitionClassFetch(char *clazz, size_t index);


@protocol NNTransition <NSObject>

@required
- (instancetype)initWithNavigationBar:(UINavigationBar *)bar;
/**
 nn_startTransitionWithParams:
 
 @param params
 key: transition
 {
    0: no anmiation
    1: push
    2: pop
    3: pop multi-viewControllers include popToRootViewController
 }
 */
- (void)nn_startTransitionWithParams:(NSDictionary *)params;
- (void)nn_endTransitionWithParams:(NSDictionary *)params;
- (void)nn_updateInteractiveTransitionWithParams:(NSDictionary *)params;
- (void)nn_endInteractiveTransitionWithParams:(NSDictionary *)params;
@optional
- (void)nn_updateBarStyleTransitionWithParams:(NSDictionary *)params;

@end

