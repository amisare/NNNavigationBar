//
//  BarBackgroundColorVC.m
//  NNNavigationBarDemo
//
//  Created by GuHaijun on 2018/4/24.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "BarBackgroundColorVC.h"

@interface BarBackgroundColorVC ()

@end

@implementation BarBackgroundColorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
    [self setupUI];
}

- (void)setupUI {
    
    [self.navigationController.navigationBar setNn_backgroundColor:[UIColor orangeColor] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setNn_backgroundColor:[UIColor purpleColor] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsCompact];
    [self.navigationController.navigationBar setNn_backgroundColor:[UIColor brownColor] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefaultPrompt];
    [self.navigationController.navigationBar setNn_backgroundColor:[UIColor cyanColor] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsCompactPrompt];
}

@end
