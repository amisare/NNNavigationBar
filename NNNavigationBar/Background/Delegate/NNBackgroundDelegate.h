//
//  UINavigationBar+NNBackgroundDelegate.h
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/24.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NNBackgroundItemDelegate <NSObject>

/**
 UINavigationItem 背景色/数据更新代理
 
 @param item UINavigationItem
 @param key  keyPath nn_backgroundColor/nn_backgroundImage
 */
- (void)nn_navigationItem:(UINavigationItem *)item backgroundChangeForKey:(NSString *)key;

@end

@protocol NNBackgroundBarDelegate <NSObject>

/**
 UINavigationBar 背景色/数据更新代理
 
 @param bar UINavigationBar
 @param key  keyPath nn_backgroundColor/nn_backgroundImage
 */
- (void)nn_navigationBar:(UINavigationBar *)bar backgroundChangeForKey:(NSString *)key;

@end
