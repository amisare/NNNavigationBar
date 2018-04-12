//
//  ColorTransitionViewController.m
//  NNNavigationBarDemo
//
//  Created by GuHaijun on 2018/4/12.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "ColorTransitionViewController.h"

@interface ColorTransitionViewController ()

@end

@implementation ColorTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.nn_backgroundViewHidden = false;
    self.navigationItem.nn_backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.colorSlider.value = self.navigationItem.nn_backgroundColor.alpha;
}

- (void)handleColorSlider:(UISlider *)colorSlider {
    [super handleColorSlider:colorSlider];
    
    self.navigationItem.nn_backgroundColor =
    [UIColor color:self.navigationItem.nn_backgroundColor
       updateAlpha:colorSlider.value];
    
    NSLog(@"%s alpha: %f", __FUNCTION__, colorSlider.value);
}

@end
