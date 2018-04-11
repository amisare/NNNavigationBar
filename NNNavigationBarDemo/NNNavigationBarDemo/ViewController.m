//
//  ViewController.m
//  NNNavigationBarDemo
//
//  Created by GuHaijun on 2018/4/11.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "ViewController.h"
#import "UINavigationBar+NNBackgroundView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"page:%@, %s", @(self.page).stringValue, __FUNCTION__);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"page:%@, %s", @(self.page).stringValue, __FUNCTION__);
    [self.navigationController setNavigationBarHidden:false animated:true];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"page:%@, %s", @(self.page).stringValue, __FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"page:%@, %s", @(self.page).stringValue, __FUNCTION__);
    
    self.title = @(self.page).stringValue;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blueColor]}];
    
    self.navigationController.navigationBar.nn_backgroundViewHidden = false;
    
//    self.navigationItem.nn_backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    self.navigationItem.nn_backgroundImage = [UIImage imageNamed:@(self.page % 2).boolValue ? @"image0" : @"image1"];
//    self.navigationController.navigationBar.nn_backgroundImageView.image = [UIImage imageNamed:@"image2"];
    
    {
        UIButton *button =[UIButton buttonWithType:UIButtonTypeSystem] ;
        [self.view addSubview:button];
        [button setTitle:@"push" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 50);
    }
    
    {
        UIButton *button =[UIButton buttonWithType:UIButtonTypeSystem] ;
        [self.view addSubview:button];
        [button setTitle:@"pop" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, 250, [UIScreen mainScreen].bounds.size.width, 50);
    }
    
    {
        UIButton *button =[UIButton buttonWithType:UIButtonTypeSystem] ;
        [self.view addSubview:button];
        [button setTitle:@"popToRoot" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(popToRoot) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, 300, [UIScreen mainScreen].bounds.size.width, 50);
    }
    
    {
        UIButton *button =[UIButton buttonWithType:UIButtonTypeSystem] ;
        [self.view addSubview:button];
        [button setTitle:@"navigationBarHide" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(hidden) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, 350, [UIScreen mainScreen].bounds.size.width, 50);
    }
    
    {
        UIButton *button =[UIButton buttonWithType:UIButtonTypeSystem] ;
        [self.view addSubview:button];
        [button setTitle:@"navigationBarShow" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, 400, [UIScreen mainScreen].bounds.size.width, 50);
    }
}

- (void)hidden {
    [self.navigationController setNavigationBarHidden:true animated:true];
}

- (void)show {
    [self.navigationController setNavigationBarHidden:false animated:true];
}

- (void)push {
    ViewController *vc = [ViewController new];
    vc.page = self.page + 1;
    [self.navigationController pushViewController:vc animated:true];
}

- (void)pop {
    [self.navigationController popViewControllerAnimated:true];
}

- (void)popToRoot {
    [self.navigationController popToRootViewControllerAnimated:true];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat alpha;
    [self.navigationItem.nn_backgroundColor getRed:&red green:&green blue:&blue alpha:&alpha];
    CGFloat touchAlpha = point.y / [UIScreen mainScreen].bounds.size.height;
    self.navigationItem.nn_backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:touchAlpha];
    
    NSLog(@"%s alpha: %f", __FUNCTION__, touchAlpha);
}

@end
