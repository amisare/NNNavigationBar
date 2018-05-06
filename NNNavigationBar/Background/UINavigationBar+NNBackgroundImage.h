//
//  UINavigationBar+NNBackgroundImage.h
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/5/6.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (NNBackgroundImage)

- (UIImage *)nn_imageForBackgroundAtBarPosition:(UIBarPosition)barPosition barMetrics:(UIBarMetrics)barMetrics;

@end
