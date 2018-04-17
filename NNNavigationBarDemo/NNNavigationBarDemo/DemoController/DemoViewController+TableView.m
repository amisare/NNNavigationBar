//
//  DemoViewController+TableView.m
//  NNNavigationBarDemo
//
//  Created by GuHaijun on 2018/4/12.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "DemoViewController+TableView.h"
#import "NSLayoutConstraint+NNVisualFormat.h"

@implementation DemoViewController (TableView)

- (void)setupTableView {
    [self.view addSubview:self.tableView];
    
    self.tableView.translatesAutoresizingMaskIntoConstraints = false;
    NSArray<NSLayoutConstraint *> *(^makeViewConstraint)(NSDictionary *view) = ^(NSDictionary *view) {
        return [NSLayoutConstraint nn_constraintsWithVisualFormats:@[[NSString stringWithFormat:@"H:|[%@]|", view.allKeys.lastObject] ,
                                                                     [NSString stringWithFormat:@"V:|[%@]|", view.allKeys.lastObject]]
                                                             views:view];
    };
    [NSLayoutConstraint activateConstraints:makeViewConstraint(@{@"tableView" : self.tableView})];
}

- (NSArray<NSString *> *)cellData {
    return @[
             @"push",
             @"pop",
             @"popStep2",
             @"popToRoot",
             @"hideNav",
             @"showNav",
             @"hidePrompt",
             @"showPrompt",
             @"dismiss"
             ];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@""];
    cell.textLabel.text = self.cellData[indexPath.row];
    if ([cell.textLabel.text isEqualToString:@"popStep2"]) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Controllers count must >= 3"];
    }
    else {
        cell.detailTextLabel.text = @"";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = false;
    
    if ([cell.textLabel.text isEqualToString:@"push"]) {
        DemoViewController *vc = [[DemoViewController alloc] initWithType:self.type];
        vc.page = self.page + 1;
        [self.navigationController pushViewController:vc animated:true];
        return;
    }
    if ([cell.textLabel.text isEqualToString:@"pop"]) {
        [self.navigationController popViewControllerAnimated:true];
        return;
    }
    if ([cell.textLabel.text isEqualToString:@"popStep2"]) {
        if (self.navigationController.viewControllers.count >= 3) {
            UIViewController *toViewController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 3];
            [self.navigationController popToViewController:toViewController animated:true];
        }
        return;
    }
    if ([cell.textLabel.text isEqualToString:@"popToRoot"]) {
        [self.navigationController popToRootViewControllerAnimated:true];
        return;
    }
    if ([cell.textLabel.text isEqualToString:@"showNav"]) {
        [self.navigationController setNavigationBarHidden:false animated:true];
        return;
    }
    if ([cell.textLabel.text isEqualToString:@"hideNav"]) {
        [self.navigationController setNavigationBarHidden:true animated:true];
        return;
    }
    if ([cell.textLabel.text isEqualToString:@"showPrompt"]) {
        self.navigationItem.prompt = @"Navigation Bar Prompt";
        return;
    }
    if ([cell.textLabel.text isEqualToString:@"hidePrompt"]) {
        self.navigationItem.prompt = nil;
        return;
    }
    if ([cell.textLabel.text isEqualToString:@"dismiss"]) {
        [self.navigationController dismissViewControllerAnimated:true completion:nil];
        return;
    }
}

@end
