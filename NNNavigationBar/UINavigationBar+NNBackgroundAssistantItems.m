//
//  UINavigationBar+NNBackgroundAssistantItems.m
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/19.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "UINavigationBar+NNBackgroundAssistantItems.h"
#import <objc/runtime.h>

static const void *kUINavigationBar_NNBackgroundAssistantItems = &kUINavigationBar_NNBackgroundAssistantItems;

@implementation UINavigationBar (NNBackgroundAssistantItems)

- (NSMutableArray<UINavigationItem *> *)assistantItems {
    NSMutableArray *assistantItems = objc_getAssociatedObject(self, kUINavigationBar_NNBackgroundAssistantItems);
    return assistantItems;
}

- (void)setAssistantItems:(NSMutableArray<UINavigationItem *> *)assistantItems {
    objc_setAssociatedObject(self, kUINavigationBar_NNBackgroundAssistantItems, assistantItems, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
