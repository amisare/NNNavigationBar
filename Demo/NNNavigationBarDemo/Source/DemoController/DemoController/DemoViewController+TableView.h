//
//  DemoViewController+TableView.h
//  NNNavigationBarDemo
//
//  Created by GuHaijun on 2018/4/12.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "DemoViewController.h"

@interface DemoViewController (TableView) <UITableViewDelegate, UITableViewDataSource>

- (void)setupTableView;

@end
