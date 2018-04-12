//
//  ColorOnlyViewController.m
//  NNNavigationBarDemo
//
//  Created by GuHaijun on 2018/4/12.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "ColorOnlyViewController.h"
#import "UIImage+NNImageWithColor.h"

@interface ColorOnlyViewController ()

@end

@implementation ColorOnlyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.nn_backgroundViewHidden = false;
    self.navigationController.navigationBar.nn_backgroundView.backgroundColor = [UIColor orangeColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.colorSlider.value = self.navigationController.navigationBar.nn_backgroundView.backgroundColor.alpha;
}

- (void)handleColorSlider:(UISlider *)colorSlider {
    [super handleColorSlider:colorSlider];
    
    self.navigationController.navigationBar.nn_backgroundView.backgroundColor =
    [UIColor color:self.navigationController.navigationBar.nn_backgroundView.backgroundColor
       updateAlpha:colorSlider.value];
    
    NSLog(@"%s alpha: %f", __FUNCTION__, colorSlider.value);
}

@end
