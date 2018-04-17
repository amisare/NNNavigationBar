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
            self.colorSlider.value = self.navigationController.navigationBar.nn_backgroundColor.alpha;
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
    
    self.navigationItem.prompt = nil;
    
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
    
    [self.navigationController.navigationBar setNn_backgroundColor:[UIColor orangeColor] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setNn_backgroundColor:[UIColor purpleColor] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsCompact];
    [self.navigationController.navigationBar setNn_backgroundColor:[UIColor brownColor] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefaultPrompt];
    [self.navigationController.navigationBar setNn_backgroundColor:[UIColor cyanColor] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsCompactPrompt];
    
    [self.colorSlider addTarget:self action:@selector(handleColorSliderColorOnly:) forControlEvents:UIControlEventValueChanged];
}

- (void)handleColorSliderColorOnly:(UISlider *)colorSlider {
    NSLog(@"%s alpha: %f", __FUNCTION__, colorSlider.value);
    
    {
        UIColor *colorUpdate = [UIColor color:[self.navigationController.navigationBar nn_backgroundColorForBarPosition:UIBarPositionAny
                                                                                                             barMetrics:UIBarMetricsDefault]
                                  updateAlpha:colorSlider.value];
        [self.navigationController.navigationBar setNn_backgroundColor:colorUpdate
                                                        forBarPosition:UIBarPositionAny
                                                            barMetrics:UIBarMetricsDefault];
    }
    {
        UIColor *colorUpdate = [UIColor color:[self.navigationController.navigationBar nn_backgroundColorForBarPosition:UIBarPositionAny
                                                                                                             barMetrics:UIBarMetricsCompact]
                                  updateAlpha:colorSlider.value];
        [self.navigationController.navigationBar setNn_backgroundColor:colorUpdate
                                                        forBarPosition:UIBarPositionAny
                                                            barMetrics:UIBarMetricsCompact];
    }
    {
        UIColor *colorUpdate = [UIColor color:[self.navigationController.navigationBar nn_backgroundColorForBarPosition:UIBarPositionAny
                                                                                                             barMetrics:UIBarMetricsDefaultPrompt]
                                  updateAlpha:colorSlider.value];
        [self.navigationController.navigationBar setNn_backgroundColor:colorUpdate
                                                        forBarPosition:UIBarPositionAny
                                                            barMetrics:UIBarMetricsDefaultPrompt];
    }
    {
        UIColor *colorUpdate = [UIColor color:[self.navigationController.navigationBar nn_backgroundColorForBarPosition:UIBarPositionAny
                                                                                                             barMetrics:UIBarMetricsCompactPrompt]
                                  updateAlpha:colorSlider.value];
        [self.navigationController.navigationBar setNn_backgroundColor:colorUpdate
                                                        forBarPosition:UIBarPositionAny
                                                            barMetrics:UIBarMetricsCompactPrompt];
    }
}

#pragma mark - DemoTypeImageOnly

- (void)setupImageOnly {
    self.navigationController.navigationBar.nn_backgroundViewHidden = false;
    [self.navigationController.navigationBar setNn_backgroundImage:[UIImage imageNamed:@"image0"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setNn_backgroundImage:[UIImage imageNamed:@"image1"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsCompact];
    [self.navigationController.navigationBar setNn_backgroundImage:[UIImage imageNamed:@"image2"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefaultPrompt];
    [self.navigationController.navigationBar setNn_backgroundImage:[UIImage imageNamed:@"image3"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsCompactPrompt];
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - DemoTypeColorTransition

- (void)setupColorTransition {
    self.navigationController.navigationBar.nn_backgroundViewHidden = false;
    
    [self.navigationController.navigationBar setNn_backgroundColor:[UIColor purpleColor] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setNn_backgroundColor:[UIColor brownColor] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsCompact];
    
    BOOL boolValue = @(self.page % 3 == 2).boolValue;
    if (boolValue) {
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
    
    [self.colorSlider addTarget:self action:@selector(handleColorSliderColorTransition:) forControlEvents:UIControlEventValueChanged];
}

- (void)handleColorSliderColorTransition:(UISlider *)colorSlider {
    NSLog(@"%s alpha: %f", __FUNCTION__, colorSlider.value);
    
    {
        UIColor *colorUpdate = [UIColor color:[self.navigationItem nn_backgroundColorForBarPosition:UIBarPositionAny
                                                                                         barMetrics:UIBarMetricsDefault]
                                  updateAlpha:colorSlider.value];
        [self.navigationItem setNn_backgroundColor:colorUpdate
                                    forBarPosition:UIBarPositionAny
                                        barMetrics:UIBarMetricsDefault];
    }
    
    {
        UIColor *colorUpdate = [UIColor color:[self.navigationItem nn_backgroundColorForBarPosition:UIBarPositionAny
                                                                                         barMetrics:UIBarMetricsCompact]
                                  updateAlpha:colorSlider.value];
        [self.navigationItem setNn_backgroundColor:colorUpdate
                                    forBarPosition:UIBarPositionAny
                                        barMetrics:UIBarMetricsCompact];
    }
}

#pragma mark - DemoTypeImageTransition

- (void)setupImageTransition {
    self.navigationController.navigationBar.nn_backgroundViewHidden = false;
    
    [self.navigationItem setNn_backgroundImage:[UIImage imageNamed:@(self.page % 2).boolValue ? @"image0" : @"image1"]
                                forBarPosition:UIBarPositionAny
                                    barMetrics:UIBarMetricsDefault];
    [self.navigationItem setNn_backgroundImage:[UIImage imageNamed:@(self.page % 2).boolValue ? @"image1" : @"image0"]
                                forBarPosition:UIBarPositionAny
                                    barMetrics:UIBarMetricsCompact];
    [self.navigationItem setNn_backgroundImage:[UIImage imageNamed:@(self.page % 2).boolValue ? @"image2" : @"image3"]
                                forBarPosition:UIBarPositionAny
                                    barMetrics:UIBarMetricsDefaultPrompt];
    [self.navigationItem setNn_backgroundImage:[UIImage imageNamed:@(self.page % 2).boolValue ? @"image3" : @"image2"]
                                forBarPosition:UIBarPositionAny
                                    barMetrics:UIBarMetricsCompactPrompt];
    
    self.tableView.tableFooterView = [UIView new];
}


#pragma mark - lazy load

- (UILabel *)colorAlphaCurrentLabel {
    if (!_colorAlphaCurrentLabel) {
        _colorAlphaCurrentLabel = [UILabel new];
        _colorAlphaCurrentLabel.textColor = [UIColor blackColor];
        _colorAlphaCurrentLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _colorAlphaCurrentLabel;
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

- (UISlider *)colorSlider {
    if (!_colorSlider) {
        _colorSlider = [UISlider new];
    }
    return _colorSlider;
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
