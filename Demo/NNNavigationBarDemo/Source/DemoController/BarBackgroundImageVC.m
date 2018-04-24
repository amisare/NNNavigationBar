//
//  BarBackgroundImageVC.m
//  NNNavigationBarDemo
//
//  Created by GuHaijun on 2018/4/24.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "BarBackgroundImageVC.h"

@interface BarBackgroundImageVC ()

@end

@implementation BarBackgroundImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
    [self setupUI];
}

- (void)setupUI {
    
    [self.navigationController.navigationBar setNn_backgroundImage:[UIImage imageNamed:@"image0"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setNn_backgroundImage:[UIImage imageNamed:@"image1"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsCompact];
    [self.navigationController.navigationBar setNn_backgroundImage:[UIImage imageNamed:@"image2"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefaultPrompt];
    [self.navigationController.navigationBar setNn_backgroundImage:[UIImage imageNamed:@"image3"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsCompactPrompt];
}

@end
