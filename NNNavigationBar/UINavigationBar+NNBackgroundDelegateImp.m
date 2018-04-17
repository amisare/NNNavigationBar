//
//  UINavigationBar+NNBackgroundDelegateImp.m
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/17.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "UINavigationBar+NNBackgroundDelegateImp.h"
#import "UINavigationBar+NNBackgroundImageView.h"

@implementation UINavigationBar (NNBackgroundDelegate)

- (void)nn_navigationBar:(UINavigationBar *)bar backgroundChangeForKey:(NSString *)key {
    
    UIImage *backgroundImage = [self nn_backgroundImageFromNavigationBar:self];
    self.nn_backgroundImageView.image = backgroundImage;
}

- (void)nn_navigationItem:(UINavigationItem *)item backgroundChangeForKey:(NSString *)key {
    
    if ([self.topItem isEqual:item]) {
        UIImage *backgroundImage = [self nn_backgroundImageFromNavigationItem:item];
        self.nn_backgroundDisplayImageView.image = backgroundImage;
    }
}

@end
