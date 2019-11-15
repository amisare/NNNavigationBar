//
//  NSLayoutConstraint+NNVisualFormat.h
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/13.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSLayoutConstraint (NNVisualFormat)


/**
 vfl布局方法
 @param formats 布局参数 {
 formats数组中可以包含两种数据类型：
     1. vfl字符串
     2. vfl字典 {
         @{
             @"format" : vfl字符串
             @"options" : constraintsWithVisualFormat中的options
             @"metrics" : constraintsWithVisualFormat中的metrics
         }
     }
 @param views 布局涉及到的view
 @return 约束数组
 */


+ (NSArray<__kindof NSLayoutConstraint *> *)nn_constraintsWithVisualFormats:(NSArray *)formats views:(NSDictionary<NSString *, id> *)views;

@end
