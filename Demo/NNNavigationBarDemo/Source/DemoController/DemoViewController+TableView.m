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
             @"popToViewController",
             @"popToRootViewController",
             @"hideNavigationBar",
             @"showNavigationBar",
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
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@""];
    cell.textLabel.text = self.cellData[indexPath.row];
    if ([cell.textLabel.text isEqualToString:@"popToViewController"]) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Jump one at pop，The controller stack count must >= 3"];
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
    if ([cell.textLabel.text isEqualToString:@"popToViewController"]) {
        if (self.navigationController.viewControllers.count >= 3) {
            UIViewController *toViewController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 3];
            [self.navigationController popToViewController:toViewController animated:true];
        }
        else {
            NSUInteger count = self.navigationController.viewControllers.count;
            NSString *message = [NSString stringWithFormat:@"Now the controller stack count = %lu", (unsigned long)count];
            message = [message stringByAppendingString:@"\n"];
            message = [message stringByAppendingString:@"The controller stack count must >= 3"];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"😂" message:message preferredStyle:UIAlertControllerStyleAlert];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [alert dismissViewControllerAnimated:true completion:nil];
            });

            [self.navigationController presentViewController:alert animated:true completion:nil];
        }
        return;
    }
    if ([cell.textLabel.text isEqualToString:@"popToRootViewController"]) {
        [self.navigationController popToRootViewControllerAnimated:true];
        return;
    }
    if ([cell.textLabel.text isEqualToString:@"showNavigationBar"]) {
        [self.navigationController setNavigationBarHidden:false animated:true];
        return;
    }
    if ([cell.textLabel.text isEqualToString:@"hideNavigationBar"]) {
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
