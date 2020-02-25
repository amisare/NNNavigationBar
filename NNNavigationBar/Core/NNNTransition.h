//
//  NNNTransition.h
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/5/18.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <os/lock.h>
#import <pthread.h>
#import <mach-o/getsect.h>
#import <mach-o/dyld.h>
#import <objc/runtime.h>

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */


typedef struct
#ifdef __LP64__
mach_header_64
#else
mach_header
#endif
nn_nav_mach_header;

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


NS_INLINE NSArray* NNNTransitionLoader() {
    NSMutableArray *transitionClazzes = [NSMutableArray new];
    uint32_t c = _dyld_image_count();
    for (uint32_t i = 0; i < c; i++) {
        nn_nav_mach_header *mhp = (nn_nav_mach_header *)_dyld_get_image_header(i);
        unsigned long size = 0;
        uintptr_t *sectionData = (uintptr_t*)getsectiondata(mhp, nn_segment_name, nn_section_name, &size);
        if (size == 0) {
            continue;
        }
        unsigned int sectionItemCount = (int)size / sizeof(nn_transition_clazz_t);
        nn_transition_clazz_t *sectionItems = (nn_transition_clazz_t *)sectionData;
        for (int i = 0; i < sectionItemCount; i++) {
            [transitionClazzes addObject:objc_getClass(sectionItems[i].clazz)];
        }
    }
    return transitionClazzes;
}
        

@protocol NNNTransition <NSObject>

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
