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

@property (nonatomic, assign) BOOL nn_backgroundViewHidden;
- (UIView *)nn_backgroundView;

@end
