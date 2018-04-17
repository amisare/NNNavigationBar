//
//  UINavigationItem+NNBackgroundItem.m
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/11.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "UINavigationItem+NNBackgroundItem.h"
#import <objc/runtime.h>
#import "UIImage+NNImageWithColor.h"
#import "UINavigationItem+NNBackgroundItemDelegate.h"

static const void *kUINavigationItem_NNBackgroundColors = &kUINavigationItem_NNBackgroundColors;
static const void *kUINavigationItem_NNBackgroundImages = &kUINavigationItem_NNBackgroundImages;

#define UINavigationItem_NNBackgroundKey(barPosition, barMetrics) [@(barPosition << (sizeof(barPosition) * 8 / 2) | barMetrics) stringValue]


@implementation UINavigationItem (NNBackgroundItem)

- (UIColor *)nn_backgroundColor {
    return [self nn_backgroundColorForBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
}

- (void)setNn_backgroundColor:(UIColor *)nn_backgroundColor {
    [self setNn_backgroundColor:nn_backgroundColor forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
}

- (UIColor *)nn_backgroundColorForBarPosition:(UIBarMetrics)barMetrics {
    UIBarPosition barPosition = UIBarPositionAny;
    return [self nn_backgroundColorForBarPosition:barPosition barMetrics:barMetrics];
}

- (void)setNn_backgroundColor:(UIColor *)backgroundColor forBarMetrics:(UIBarMetrics)barMetrics {
    UIBarPosition barPosition = UIBarPositionAny;
    [self setNn_backgroundColor:backgroundColor forBarPosition:barPosition barMetrics:barMetrics];
}

- (UIColor *)nn_backgroundColorForBarPosition:(UIBarPosition)barPosition barMetrics:(UIBarMetrics)barMetrics {
    NSString *key = UINavigationItem_NNBackgroundKey(barPosition, barMetrics);
    NSDictionary *backgroundColors = [self nn_backgroundColors];
    return [backgroundColors objectForKey:key];
}

- (void)setNn_backgroundColor:(UIColor *)backgroundColor forBarPosition:(UIBarPosition)barPosition barMetrics:(UIBarMetrics)barMetrics {
    NSString *key = UINavigationItem_NNBackgroundKey(barPosition, barMetrics);
    if (backgroundColor == nil) {
        [[self nn_backgroundColors] removeObjectForKey:key];
    }
    else {
        [[self nn_backgroundColors] setObject:backgroundColor forKey:key];
    }
    if (self.nn_backgroundItemDelegate &&
        [self.nn_backgroundItemDelegate respondsToSelector:@selector(nn_navigationItem:backgroundChangeForKey:)]) {
        [self.nn_backgroundItemDelegate nn_navigationItem:self backgroundChangeForKey:@"nn_backgroundColor"];
    }
}

- (NSMutableDictionary *)nn_backgroundColors {
    NSMutableDictionary *nn_backgroundColors = objc_getAssociatedObject(self, kUINavigationItem_NNBackgroundColors);
    if (!nn_backgroundColors) {
        nn_backgroundColors = [NSMutableDictionary new];
        objc_setAssociatedObject(self, kUINavigationItem_NNBackgroundColors, nn_backgroundColors, OBJC_ASSOCIATION_RETAIN);
    }
    return nn_backgroundColors;
}

- (UIImage *)nn_backgroundImage {
    return [self nn_backgroundImageForBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
}

- (void)setNn_backgroundImage:(UIImage *)nn_backgroundImage {
    [self setNn_backgroundImage:nn_backgroundImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
}

- (UIImage *)nn_backgroundImageForBarMetrics:(UIBarMetrics)barMetrics {
    UIBarPosition barPosition = UIBarPositionAny;
    return [self nn_backgroundImageForBarPosition:barPosition barMetrics:barMetrics];
}

- (void)setNn_backgroundImage:(UIImage *)backgroundImage forBarMetrics:(UIBarMetrics)barMetrics {
    UIBarPosition barPosition = UIBarPositionAny;
    [self setNn_backgroundImage:backgroundImage forBarPosition:barPosition barMetrics:barMetrics];
}

- (UIImage *)nn_backgroundImageForBarPosition:(UIBarPosition)barPosition barMetrics:(UIBarMetrics)barMetrics {
    NSString *key = UINavigationItem_NNBackgroundKey(barPosition, barMetrics);
    NSDictionary *backgroundImages = [self nn_backgroundImages];
    return [backgroundImages objectForKey:key];
}

- (void)setNn_backgroundImage:(UIImage *)backgroundImage forBarPosition:(UIBarPosition)barPosition barMetrics:(UIBarMetrics)barMetrics {
    NSString *key = UINavigationItem_NNBackgroundKey(barPosition, barMetrics);
    if (backgroundImage == nil) {
        [[self nn_backgroundImages] removeObjectForKey:key];
    }
    else {
        [[self nn_backgroundImages] setObject:backgroundImage forKey:key];
    }
    if (self.nn_backgroundItemDelegate &&
        [self.nn_backgroundItemDelegate respondsToSelector:@selector(nn_navigationItem:backgroundChangeForKey:)]) {
        [self.nn_backgroundItemDelegate nn_navigationItem:self backgroundChangeForKey:@"nn_backgroundImage"];
    }
}

- (NSMutableDictionary *)nn_backgroundImages {
    NSMutableDictionary *nn_backgroundImages = objc_getAssociatedObject(self, kUINavigationItem_NNBackgroundImages);
    if (!nn_backgroundImages) {
        nn_backgroundImages = [NSMutableDictionary new];
        objc_setAssociatedObject(self, kUINavigationItem_NNBackgroundImages, nn_backgroundImages, OBJC_ASSOCIATION_RETAIN);
    }
    return nn_backgroundImages;
}

@end
