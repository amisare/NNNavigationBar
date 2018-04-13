//
//  DemoViewController.h
//  NNNavigationBarDemo
//
//  Created by GuHaijun on 2018/4/13.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NNNavigationBar.h"
#import "UIColor+Help.h"

typedef NS_ENUM(NSUInteger, DemoType) {
    DemoTypeColorOnly,
    DemoTypeImageOnly,
    DemoTypeColorTransition,
    DemoTypeImageTransition,
};

@interface DemoViewController : UIViewController

- (instancetype)initWithType:(DemoType)type;

@property (nonatomic, assign) DemoType type;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISlider *colorSlider;
@property (nonatomic, strong) UILabel *colorAlphaMixLabel;
@property (nonatomic, strong) UILabel *colorAlphaMaxLabel;
@property (nonatomic, strong) UILabel *colorAlphaCurrentLabel;

@end
