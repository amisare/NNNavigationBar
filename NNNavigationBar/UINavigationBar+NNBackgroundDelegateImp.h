//
//  UINavigationBar+NNBackgroundDelegateImp.h
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/17.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationBar+NNBackgroundBarDelegate.h"
#import "UINavigationItem+NNBackgroundItemDelegate.h"

@interface UINavigationBar (NNBackgroundDelegate) <NNBackgroundBarDelegate, NNBackgroundItemDelegate>

@end
