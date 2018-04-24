//
//  ItemBackgroundColorVC.m
//  NNNavigationBarDemo
//
//  Created by GuHaijun on 2018/4/24.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "ItemBackgroundColorVC.h"

@interface ItemBackgroundColorVC ()

@end

@implementation ItemBackgroundColorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
    [self setupUI];
}

- (void)setupUI {
    
    [self.navigationItem setNn_backgroundColor:[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1]
                                forBarPosition:UIBarPositionAny
                                    barMetrics:UIBarMetricsDefault];
    [self.navigationItem setNn_backgroundColor:[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1]
                                forBarPosition:UIBarPositionAny
                                    barMetrics:UIBarMetricsCompact];
    [self.navigationItem setNn_backgroundColor:[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1]
                                forBarPosition:UIBarPositionAny
                                    barMetrics:UIBarMetricsDefaultPrompt];
    [self.navigationItem setNn_backgroundColor:[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1]
                                forBarPosition:UIBarPositionAny
                                    barMetrics:UIBarMetricsCompactPrompt];
}

@end
