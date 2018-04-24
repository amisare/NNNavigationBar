//
//  ItemBackgroundAlphaVC.m
//  NNNavigationBarDemo
//
//  Created by GuHaijun on 2018/4/24.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "ItemBackgroundAlphaVC.h"

@interface ItemBackgroundAlphaVC ()

@end

@implementation ItemBackgroundAlphaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    self.colorSlider.value = self.navigationItem.nn_backgroundAlpha;
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
    
    [self.colorSlider addTarget:self action:@selector(handleColorSlider:) forControlEvents:UIControlEventValueChanged];
}

- (void)handleColorSlider:(UISlider *)colorSlider {
    self.navigationItem.nn_backgroundAlpha = colorSlider.value;
}

@end
