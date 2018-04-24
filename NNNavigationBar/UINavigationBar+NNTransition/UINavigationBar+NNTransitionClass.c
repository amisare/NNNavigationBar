//
//  UINavigationBar+NNTransitionClass.c
//  NNNavigationBarDemo
//
//  Created by GuHaijun on 2018/4/24.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#include "UINavigationBar+NNTransitionClass.h"

#define MAX_CLAZZ_COUNT                      256
#define MAX_CLAZZ_LENGTH                     256

static char clazzs[MAX_CLAZZ_COUNT][MAX_CLAZZ_LENGTH] = {0};

int NNTransitionClassRegister(const char *clazz, size_t length) {
    
    assert(length < MAX_CLAZZ_LENGTH);
    for (int i = 0; i < MAX_CLAZZ_COUNT; i++) {
        char *t_clazz = clazzs[i];
        size_t t_length = strlen(t_clazz);
        if (t_length != 0) {
            if (0 == strcmp(t_clazz, clazz)) {
                // Has been registered
                return 0;
            }
            else {
                continue;
            }
        }
        strcpy(t_clazz, clazz);
        return 0;
    }
    
    return -1;
}

size_t NNTransitionClassCount(void) {
    
    for (int i = 0; i < MAX_CLAZZ_COUNT; i++) {
        if (strlen(clazzs[i]) == 0) {
            return ++i;
        }
    }
    return 0;
}

int NNTransitionClassFetch(char *clazz, size_t index) {
    
    assert(index < MAX_CLAZZ_COUNT);
    if (index > MAX_CLAZZ_COUNT) {
        return -1;
    }
    strcpy(clazz, clazzs[index]);
    return 0;
}

int NNTransitionClassUnregister(const char *clazz, size_t length) {
    
    assert(length < MAX_CLAZZ_LENGTH);
    for (int i = 0; i < MAX_CLAZZ_COUNT; i++) {
        char *t_clazz = clazzs[i];
        if (0 == strcmp(t_clazz, clazz)) {
            memset(t_clazz, 0, MAX_CLAZZ_LENGTH);
            return 0;
        }
    }
    return -1;
}

int NNTransitionClassIndex(char *clazz, size_t length) {
    
    assert(length < MAX_CLAZZ_LENGTH);
    for (int i = 0; i < MAX_CLAZZ_COUNT; i++) {
        char *t_clazz = clazzs[i];
        if (0 == strcmp(t_clazz, clazz)) {
            return i;
        }
    }
    return -1;
}
