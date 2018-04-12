//
//  DemoBaseViewController.h
//  NNNavigationBarDemo
//
//  Created by GuHaijun on 2018/4/11.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NNNavigationBar.h"
#import "UIColor+Help.h"

@interface DemoBaseViewController : UIViewController

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISlider *colorSlider;
- (void)handleColorSlider:(UISlider *)colorSlider;

@end

