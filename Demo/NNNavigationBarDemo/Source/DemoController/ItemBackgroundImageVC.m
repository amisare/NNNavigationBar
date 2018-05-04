//
//  ItemBackgroundImageVC.m
//  NNNavigationBarDemo
//
//  Created by GuHaijun on 2018/4/24.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "ItemBackgroundImageVC.h"

@interface ItemBackgroundImageVC ()

@end

@implementation ItemBackgroundImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
    [self setupUI];
}

- (void)setupUI {
    [self.navigationItem setNn_backgroundTransitionAlpha:@(self.page % 2).boolValue];
    [self.navigationItem setNn_backgroundImage:[UIImage imageNamed:@(self.page % 2).boolValue ? @"image0" : @"image1"]
                                forBarPosition:UIBarPositionAny
                                    barMetrics:UIBarMetricsDefault];
    [self.navigationItem setNn_backgroundImage:[UIImage imageNamed:@(self.page % 2).boolValue ? @"image1" : @"image0"]
                                forBarPosition:UIBarPositionAny
                                    barMetrics:UIBarMetricsCompact];
    [self.navigationItem setNn_backgroundImage:[UIImage imageNamed:@(self.page % 2).boolValue ? @"image2" : @"image3"]
                                forBarPosition:UIBarPositionAny
                                    barMetrics:UIBarMetricsDefaultPrompt];
    [self.navigationItem setNn_backgroundImage:[UIImage imageNamed:@(self.page % 2).boolValue ? @"image3" : @"image2"]
                                forBarPosition:UIBarPositionAny
                                    barMetrics:UIBarMetricsCompactPrompt];
}

@end
