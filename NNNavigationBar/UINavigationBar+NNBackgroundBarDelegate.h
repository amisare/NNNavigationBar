//
//  UINavigationBar+NNBackgroundBarDelegate.h
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/17.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NNBackgroundBarDelegate <NSObject>

/**
 UINavigationBar 背景色/数据更新代理
 
 @param bar UINavigationBar
 @param key  keyPath nn_backgroundColor/nn_backgroundImage
 */
- (void)nn_navigationBar:(UINavigationBar *)bar backgroundChangeForKey:(NSString *)key;

@end

@interface UINavigationBar (NNBackgroundBarDelegate)

@property (nonatomic, strong) id<NNBackgroundBarDelegate> nn_backgroundBarDelegate;

@end
