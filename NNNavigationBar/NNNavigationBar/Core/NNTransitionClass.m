//
//  NNTransitionClass.m
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/5/18.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "NNTransitionClass.h"
#import <os/lock.h>
#import <pthread.h>
#import <mach-o/getsect.h>
#import <mach-o/dyld.h>

typedef struct
#ifdef __LP64__
mach_header_64
#else
mach_header
#endif
nn_pop_mach_header;

unsigned int nn_transitionClazzCount = 0;
nn_transition_clazz_t *nn_transitionClazzes = nil;

static pthread_mutex_t nn_pop_injectLock = PTHREAD_MUTEX_INITIALIZER;

/// Loads protocol extensions info from image segment
/// @param mhp A mach header appears at the very beginning of the object file
void nn_pop_loadSection(const struct mach_header* mhp, intptr_t vmaddr_slide) {
    
    if (pthread_mutex_lock(&nn_pop_injectLock) != 0) {
        fprintf(stderr, "ERROR: Could not synchronize on special protocol data\n");
    }
    
    unsigned long size = 0;
    uintptr_t *sectionData = (uintptr_t*)getsectiondata((nn_pop_mach_header *)mhp, nn_segment_name, nn_section_name, &size);
    if (size == 0) {
        pthread_mutex_unlock(&nn_pop_injectLock);
        return;
    }
    nn_transitionClazzes = (nn_transition_clazz_t *)malloc(size);
    if (nn_transitionClazzes == nil) {
        pthread_mutex_unlock(&nn_pop_injectLock);
        return;
    }
    memset(nn_transitionClazzes, 0, size);
    memcpy(nn_transitionClazzes, sectionData, size);
    nn_transitionClazzCount = (unsigned int)(size / sizeof(nn_transition_clazz_t));
    
    pthread_mutex_unlock(&nn_pop_injectLock);
}

__attribute__((constructor)) void nn_nav_initializer(void) {
    _dyld_register_func_for_add_image(nn_pop_loadSection);
}
