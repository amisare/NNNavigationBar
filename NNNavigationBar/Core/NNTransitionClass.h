//
//  NNTransitionClass.h
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/5/18.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

typedef struct {
    const char *clazz;
}nn_transition_clazz_t;

extern unsigned int nn_transitionClazzCount;
extern nn_transition_clazz_t *nn_transitionClazzes;

#define nn_segment_name             "__DATA"
#define nn_section_name             "__nn_nav_bar__"
#define nn_section(section_name)    __attribute__((used, section(nn_segment_name "," section_name )))
#define nn_transition(clazz) \
        \
        class NSObject; \
        \
        const nn_transition_clazz_t k_nn_transition_##clazz nn_section(nn_section_name) = { \
            #clazz\
        };
        

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

#ifdef __cplusplus
}
#endif /* __cplusplus */
