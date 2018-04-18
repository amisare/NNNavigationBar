//
//  MainViewController.m
//  NNNavigationBarDemo
//
//  Created by GuHaijun on 2018/4/12.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "MainViewController.h"
#import "DemoViewController.h"
#import "NSLayoutConstraint+NNVisualFormat.h"

@interface MainViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"main";
    [self.view addSubview:self.tableView];
    
    self.tableView.translatesAutoresizingMaskIntoConstraints = false;
    NSArray<NSLayoutConstraint *> *(^makeViewConstraint)(NSDictionary *view) = ^(NSDictionary *view) {
        return [NSLayoutConstraint nn_constraintsWithVisualFormats:@[[NSString stringWithFormat:@"H:|[%@]|", view.allKeys.lastObject] ,
                                                                     [NSString stringWithFormat:@"V:|[%@]|", view.allKeys.lastObject]]
                                                             views:view];
    };
    [NSLayoutConstraint activateConstraints:makeViewConstraint(@{@"tableView" : self.tableView})];
}

- (NSArray<NSDictionary *> *)cellData {
    return @[
             @{@"title"     : @"Set the backgroundColor on NavigationBar",
               @"subtitle"  : @"The background attribute is globally valid"
               },
             
             @{@"title"     : @"Set the backgroundImage on NavigationBar",
               @"subtitle"  : @"The background attribute is globally valid",
               },
             
             @{@"title"     : @"Set the backgroundColor on NavigationItem",
               @"subtitle"  : @"The background property is currently valid",
               },
             
             @{@"title"     : @"Set the backgroundImage on NavigationItem",
               @"subtitle"  : @"The background property is currently valid",
               }
             ];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 66;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@""];
    cell.textLabel.text = [self.cellData[indexPath.row] objectForKey:@"title"];
    cell.detailTextLabel.text = [self.cellData[indexPath.row] objectForKey:@"subtitle"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = false;
    
    DemoType type = DemoTypeColorOnly;
    if ([cell.textLabel.text isEqualToString:@"Set the backgroundColor on NavigationBar"]) {
        type = DemoTypeColorOnly;
    }
    if ([cell.textLabel.text isEqualToString:@"Set the backgroundImage on NavigationBar"]) {
        type = DemoTypeImageOnly;
    }
    if ([cell.textLabel.text isEqualToString:@"Set the backgroundColor on NavigationItem"]) {
        type = DemoTypeColorTransition;
    }
    if ([cell.textLabel.text isEqualToString:@"Set the backgroundImage on NavigationItem"]) {
        type = DemoTypeImageTransition;
    }
    
    DemoViewController *vc = [[DemoViewController alloc] initWithType:type];
    UINavigationController *nav = [[UINavigationController alloc] initWithNavigationBarClass:[UINavigationBar class] toolbarClass:[UIToolbar class]];
    [nav pushViewController:vc animated:false];
    [self presentViewController:nav animated:true completion:nil];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
