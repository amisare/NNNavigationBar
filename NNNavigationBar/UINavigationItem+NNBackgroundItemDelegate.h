//
//  UINavigationItem+NNBackgroundItemDelegate.h
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/11.
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

@interface UINavigationItem (NNBackgroundItemDelegate)

@property (nonatomic, strong) id<NNBackgroundItemDelegate> nn_backgroundItemDelegate;

@end
