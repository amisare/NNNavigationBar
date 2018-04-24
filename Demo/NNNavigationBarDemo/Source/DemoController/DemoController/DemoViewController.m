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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"page:%@, %s", @(self.page).stringValue, __FUNCTION__);
    
    [self.navigationController setNavigationBarHidden:false animated:true];
    //set prompt (show if self.prompt is not null)
    self.navigationItem.prompt = self.prompt;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"page:%@, %s", @(self.page).stringValue, __FUNCTION__);
    //hide prompt
    self.navigationItem.prompt = nil;
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
    
    [self setupTableView];
    [self setupSlider];
}

- (void)setPrompt:(NSString *)prompt {
    _prompt = prompt;
    self.navigationItem.prompt = _prompt;
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

- (void)dealloc {
    NSLog(@"dealloc");
}

@end
