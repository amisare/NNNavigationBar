//
//  ImageOnlyViewController.m
//  NNNavigationBarDemo
//
//  Created by GuHaijun on 2018/4/12.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "ImageOnlyViewController.h"

@interface ImageOnlyViewController ()

@end

@implementation ImageOnlyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.nn_backgroundViewHidden = false;
    self.navigationController.navigationBar.nn_backgroundImageView.image = [UIImage imageNamed:@"image2"];
    self.tableView.tableFooterView = [UIView new];
}

@end
