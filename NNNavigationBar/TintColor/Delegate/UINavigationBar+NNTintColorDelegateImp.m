//
//  UINavigationBar+NNTintColorDelegateImp.m
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/24.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "UINavigationBar+NNTintColorDelegateImp.h"
#import "UINavigationItem+NNTintColor.h"

@implementation UINavigationBar (NNTintColorDelegateImp)

- (void)nn_navigationBar:(UINavigationBar *)bar tintColorChange:(NSDictionary *)colors {
    
    if (self.topItem.nn_tintColor) {
        return;
    }
    
    UIColor *tintColor = [colors objectForKey:@"tintColorNew"];
    if (tintColor) {
        self.tintColor = tintColor;
    }
}

- (void)nn_navigationItem:(UINavigationItem *)item tintColorChange:(NSDictionary *)colors {
    
    if (![item isEqual:self.topItem]) {
        return;
    }
    
    UIColor *tintColor = [colors objectForKey:@"tintColorNew"];
    if (tintColor) {
        self.tintColor = tintColor;
    }
}

@end
