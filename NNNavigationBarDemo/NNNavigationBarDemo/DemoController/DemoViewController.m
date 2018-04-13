//
//  DemoViewController.m
//  NNNavigationBarDemo
//
//  Created by GuHaijun on 2018/4/13.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "DemoViewController.h"
#import "DemoViewController+Slider.h"
#import "DemoViewController+TableView.h"

@interface DemoViewController ()

@end

@implementation DemoViewController

- (instancetype)initWithType:(DemoType)type {
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"page:%@, %s", @(self.page).stringValue, __FUNCTION__);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"page:%@, %s", @(self.page).stringValue, __FUNCTION__);
    
    [self.navigationController setNavigationBarHidden:false animated:true];
    
    switch (self.type) {
        case DemoTypeColorOnly:
            self.colorSlider.value = self.navigationController.navigationBar.nn_backgroundView.backgroundColor.alpha;
            break;
        case DemoTypeColorTransition:
            self.colorSlider.value = self.navigationItem.nn_backgroundColor.alpha;
            break;
            
        default:
            break;
    }
    
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
    
    [self setupTableView];
    [self setupSlider];
    
    switch (self.type) {
        case DemoTypeColorOnly:
            [self setupColorOnly];
            break;
            
        case DemoTypeImageOnly:
            [self setupImageOnly];
            break;
            
        case DemoTypeColorTransition:
            [self setupColorTransition];
            break;
            
        case DemoTypeImageTransition:
            [self setupImageTransition];
            break;
            
        default:
            break;
    }
}

#pragma mark - DemoTypeColorOnly

- (void)setupColorOnly {
    self.navigationController.navigationBar.nn_backgroundViewHidden = false;
    self.navigationController.navigationBar.nn_backgroundView.backgroundColor = [UIColor orangeColor];
    [self.colorSlider addTarget:self action:@selector(handleColorSliderColorOnly:) forControlEvents:UIControlEventValueChanged];
}

- (void)handleColorSliderColorOnly:(UISlider *)colorSlider {
    NSLog(@"%s alpha: %f", __FUNCTION__, colorSlider.value);
    UIColor *colorUpdate = [UIColor color:self.navigationController.navigationBar.nn_backgroundView.backgroundColor updateAlpha:colorSlider.value];
    self.navigationController.navigationBar.nn_backgroundView.backgroundColor = colorUpdate;
}

#pragma mark - DemoTypeImageOnly

- (void)setupImageOnly {
    self.navigationController.navigationBar.nn_backgroundViewHidden = false;
    self.navigationController.navigationBar.nn_backgroundImageView.image = [UIImage imageNamed:@"image2"];
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - DemoTypeColorTransition

- (void)setupColorTransition {
    self.navigationController.navigationBar.nn_backgroundViewHidden = false;
    self.navigationItem.nn_backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    [self.colorSlider addTarget:self action:@selector(handleColorSliderColorTransition:) forControlEvents:UIControlEventValueChanged];
}

- (void)handleColorSliderColorTransition:(UISlider *)colorSlider {
    NSLog(@"%s alpha: %f", __FUNCTION__, colorSlider.value);
    UIColor *colorUpdate = [UIColor color:self.navigationItem.nn_backgroundColor updateAlpha:colorSlider.value];
    self.navigationItem.nn_backgroundColor = colorUpdate;
}

#pragma mark - DemoTypeImageTransition

- (void)setupImageTransition {
    self.navigationController.navigationBar.nn_backgroundViewHidden = false;
    self.navigationItem.nn_backgroundImage = [UIImage imageNamed:@(self.page % 2).boolValue ? @"image0" : @"image1"];
    self.tableView.tableFooterView = [UIView new];
}


#pragma mark - lazy load

- (UISlider *)colorSlider {
    if (!_colorSlider) {
        _colorSlider = [UISlider new];
    }
    return _colorSlider;
}

- (UILabel *)colorAlphaMixLabel {
    if (!_colorAlphaMixLabel) {
        _colorAlphaMixLabel = [UILabel new];
        _colorAlphaMixLabel.textColor = [UIColor blackColor];
        _colorAlphaMixLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _colorAlphaMixLabel;
}

- (UILabel *)colorAlphaMaxLabel {
    if (!_colorAlphaMaxLabel) {
        _colorAlphaMaxLabel = [UILabel new];
        _colorAlphaMaxLabel.textColor = [UIColor blackColor];
        _colorAlphaMaxLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _colorAlphaMaxLabel;
}

- (UILabel *)colorAlphaCurrentLabel {
    if (!_colorAlphaCurrentLabel) {
        _colorAlphaCurrentLabel = [UILabel new];
        _colorAlphaCurrentLabel.textColor = [UIColor blackColor];
        _colorAlphaCurrentLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _colorAlphaCurrentLabel;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
