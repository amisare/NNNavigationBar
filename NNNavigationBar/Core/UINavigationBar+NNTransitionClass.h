//
//  UINavigationBar+NNTransitionClass.h
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/24.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#ifndef UINavigationBar_NNTransitionClass_h
#define UINavigationBar_NNTransitionClass_h

#include <stdio.h>
#include <string.h>
#include <assert.h>

int NNTransitionClassRegister(const char *clazz, size_t length);
size_t NNTransitionClassCount(void);
int NNTransitionClassFetch(char *clazz, size_t index);

#endif /* UINavigationBar_NNTransitionClass_h */
