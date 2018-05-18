//
//  UINavigationBar+NNBackgroundDelegateImp.h
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/17.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationBar+NNCoreProperties.h"
#import "UINavigationItem+NNCoreProperties.h"
#import "UINavigationBar+NNBackgroundDelegate.h"
#import "UINavigationItem+NNBackgroundDelegate.h"

@interface UINavigationBar (NNBackgroundDelegate) <NNBackgroundBarDelegate, NNBackgroundItemDelegate>

@end
