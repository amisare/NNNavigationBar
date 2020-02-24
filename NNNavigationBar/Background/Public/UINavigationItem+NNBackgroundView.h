//
//  UINavigationItem+NNBackgroundView.h
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/11.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NNNavigationBarBackgroundView.h"

@interface UINavigationItem (NNBackgroundView) <NNNavigationBarBackgroundView>

//A float value for nn_backgroundView Alpha
@property (nonatomic, assign) CGFloat nn_backgroundAlpha;

@end
