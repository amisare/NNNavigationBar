//
//  UINavigationBar+NNBackgroundView.h
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/11.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NNNavigationBarBackgroundView.h"

@interface UINavigationBar (NNBackgroundView) <NNNavigationBarBackgroundView>

@property (nonatomic, assign) BOOL nn_backgroundViewHidden;  //default is false
@property (nonatomic, strong, readonly) UIView *nn_backgroundView; //background content view

@end
