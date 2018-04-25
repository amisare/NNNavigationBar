//
//  UINavigationBar+NNAssistantItems.m
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/19.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "UINavigationBar+NNAssistantItems.h"
#import <objc/runtime.h>

static const void *kUINavigationBar_NNAssistantItems = &kUINavigationBar_NNAssistantItems;

@implementation UINavigationBar (NNAssistantItems)

- (NSMutableArray<UINavigationItem *> *)assistantItems {
    NSMutableArray *assistantItems = objc_getAssociatedObject(self, kUINavigationBar_NNAssistantItems);
    return assistantItems;
}

- (void)setAssistantItems:(NSMutableArray<UINavigationItem *> *)assistantItems {
    objc_setAssociatedObject(self, kUINavigationBar_NNAssistantItems, assistantItems, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
