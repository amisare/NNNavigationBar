//
//  UINavigationBar+NNCoreProperties.h
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/5/18.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NNTransitionClass.h"

@interface UINavigationBar (NNBarStyle)
@property (nonatomic, assign) UIBarPosition nn_sbarPosition;
@property (nonatomic, assign) UIBarMetrics nn_sbarMetrics;
@end

@interface UINavigationBar (NNDelegate)
@property (nonatomic, weak) id nn_delegate;
@end

@interface UINavigationBar (NNTransition)
- (NSArray<id<NNTransition>> *)nn_transitions;
@end

@interface UINavigationBar (NNLatestPopItem)
@property (nonatomic, weak) UINavigationItem *nn_latestPopItem;
@end
