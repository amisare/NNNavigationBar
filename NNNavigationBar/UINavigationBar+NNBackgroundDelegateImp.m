//
//  UINavigationBar+NNBackgroundDelegateImp.m
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/17.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "UINavigationBar+NNBackgroundDelegateImp.h"
#import "UINavigationBar+NNBackgroundImageView.h"
#import "UINavigationBar+NNBackgroundView.h"

@implementation UINavigationBar (NNBackgroundDelegate)

- (void)nn_navigationBar:(UINavigationBar *)bar backgroundChangeForKey:(NSString *)key {
    
    UIImage *backgroundImage = [self nn_backgroundImageFromNavigationBar:self];
    self.nn_backgroundImageView.image = backgroundImage;
}

- (void)nn_navigationItem:(UINavigationItem *)item backgroundChangeForKey:(NSString *)key {
    
    if (![self.topItem isEqual:item]) {
        return;
    }
    
    if ([key isEqualToString:@"nn_backgroundColor"] || [key isEqualToString:@"nn_backgroundImage"]) {
        UIImage *backgroundImage = [self nn_backgroundImageFromNavigationItem:item];
        self.nn_backgroundDisplayImageView.image = backgroundImage;
    }
    
    if ([key isEqualToString:@"nn_backgroundAlpha"]) {
        self.nn_backgroundView.alpha = item.nn_backgroundAlpha;
    }
}

@end
