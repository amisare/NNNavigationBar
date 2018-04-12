//
//  ImageTransitionViewController.m
//  NNNavigationBarDemo
//
//  Created by GuHaijun on 2018/4/12.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "ImageTransitionViewController.h"

@interface ImageTransitionViewController ()

@end

@implementation ImageTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.nn_backgroundViewHidden = false;
    self.navigationItem.nn_backgroundImage = [UIImage imageNamed:@(self.page % 2).boolValue ? @"image0" : @"image1"];
    self.tableView.tableFooterView = [UIView new];
}

@end
