//
//  DemoBaseViewController.m
//  NNNavigationBarDemo
//
//  Created by GuHaijun on 2018/4/11.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "DemoBaseViewController.h"
#import "DemoBaseViewController+TableViewDelegate.h"

@interface DemoBaseViewController ()

@property (nonatomic, strong) UILabel *colorAlphaMixLabel;
@property (nonatomic, strong) UILabel *colorAlphaMaxLabel;
@property (nonatomic, strong) UILabel *colorAlphaCurrentLabel;

@end

@implementation DemoBaseViewController

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
    
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
    
    {
        UIView *colorSliderContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 66)];
        
        [colorSliderContentView addSubview:self.colorAlphaCurrentLabel];
        self.colorAlphaCurrentLabel.frame = CGRectMake(0,
                                                       0,
                                                       self.view.bounds.size.width,
                                                       22);
        [colorSliderContentView addSubview:self.colorAlphaMixLabel];
        self.colorAlphaMixLabel.frame = CGRectMake(0,
                                                   self.colorAlphaCurrentLabel.frame.origin.y +
                                                   self.colorAlphaCurrentLabel.frame.size.height,
                                                   44,
                                                   44);
        [colorSliderContentView addSubview:self.colorAlphaMaxLabel];
        self.colorAlphaMaxLabel.frame = CGRectMake(self.colorAlphaCurrentLabel.frame.size.width - 44,
                                                   self.colorAlphaCurrentLabel.frame.origin.y +
                                                   self.colorAlphaCurrentLabel.frame.size.height,
                                                   44,
                                                   44);
        [colorSliderContentView addSubview:self.colorSlider];
        self.colorSlider.frame = CGRectMake(self.colorAlphaMixLabel.frame.size.width,
                                            self.colorAlphaCurrentLabel.frame.origin.y +
                                            self.colorAlphaCurrentLabel.frame.size.height,
                                            self.colorAlphaCurrentLabel.frame.size.width -
                                            self.colorAlphaMixLabel.frame.size.width -
                                            self.colorAlphaMaxLabel.frame.size.width,
                                            44);
        
        self.tableView.tableFooterView = colorSliderContentView;
    }
    
    self.colorAlphaMixLabel.text = [NSString stringWithFormat:@"%0.1f", self.colorSlider.minimumValue];
    self.colorAlphaMaxLabel.text = [NSString stringWithFormat:@"%0.1f", self.colorSlider.maximumValue];

    [self.colorSlider addObserver:self forKeyPath:@"value" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"value"]) {
        if (change[NSKeyValueChangeNewKey] != [NSNull null] && change[NSKeyValueChangeNewKey] != nil) {
            self.colorAlphaCurrentLabel.text = [[change objectForKey:NSKeyValueChangeNewKey] stringValue];
        }
    }
}

- (void)handleColorSlider:(UISlider *)colorSlider {
    self.colorAlphaCurrentLabel.text = @(self.colorSlider.value).stringValue;
}

- (UISlider *)colorSlider {
    if (!_colorSlider) {
        _colorSlider = [UISlider new];
        [_colorSlider addTarget:self action:@selector(handleColorSlider:) forControlEvents:UIControlEventValueChanged];
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
