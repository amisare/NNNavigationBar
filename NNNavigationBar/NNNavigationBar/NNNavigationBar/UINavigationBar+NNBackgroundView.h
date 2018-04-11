//
//  UINavigationBar+NNBackgroundView.h
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/11.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationItem+NNBackgroundItem.h"

@interface UINavigationBar (NNBackgroundView)

@property (nonatomic, assign) BOOL nn_backgroundViewHidden;
- (UIView *)nn_backgroundView;
- (UIImageView *)nn_backgroundImageView;

@end
