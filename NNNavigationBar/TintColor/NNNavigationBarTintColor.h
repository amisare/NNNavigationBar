//
//  NNNavigationBarTintColor.h
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/5/18.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NNNavigationBarTintColor <NSObject>

@property (nonatomic, strong) UIColor *nn_tintColor NS_DEPRECATED_IOS(1_0, 2_0, "Although the effect is achieved, there is a bug that cannot be solved. You can try to use UINavigationItem at each viewController to achieve the demand, also see: https://github.com/amisare/NNNavigationBar/issues/5#issuecomment-439857192");

@end
