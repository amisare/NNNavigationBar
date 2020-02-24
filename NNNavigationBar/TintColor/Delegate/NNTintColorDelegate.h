//
//  UINavigationBar+NNTintColorDelegate.h
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/24.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NNTintColorItemDelegate <NSObject>

/**
 UINavigationItem tintColor更新代理
 
 @param item UINavigationItem
 @param colors  @"tintColorOld"/@"tintColorNew"
 */
- (void)nn_navigationItem:(UINavigationItem *)item tintColorChange:(NSDictionary *)colors;

@end

@protocol NNTintColorBarDelegate <NSObject>

/**
 UINavigationBar tintColor更新代理
 
 @param bar UINavigationBar
 @param colors  @"tintColorOld"/@"tintColorNew"
 */
- (void) nn_navigationBar:(UINavigationBar *)bar tintColorChange:(NSDictionary *)colors;

@end
