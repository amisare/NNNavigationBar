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
    return [self backgroundColorForBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
}

- (void)setNn_backgroundColor:(UIColor *)nn_backgroundColor {
    [self setBackgroundColor:nn_backgroundColor forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    if (self.nn_backgroundItemDelegate &&
        [self.nn_backgroundItemDelegate respondsToSelector:@selector(nn_navigationItem:backgroundItemChangeForKey:)]) {
        [self.nn_backgroundItemDelegate nn_navigationItem:self backgroundItemChangeForKey:@"nn_backgroundColor"];
    }
}

- (UIImage *)nn_backgroundImage {
    return [self backgroundImageForBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
}

- (void)setNn_backgroundImage:(UIImage *)nn_backgroundImage {
    [self setBackgroundImage:nn_backgroundImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    if (self.nn_backgroundItemDelegate &&
        [self.nn_backgroundItemDelegate respondsToSelector:@selector(nn_navigationItem:backgroundItemChangeForKey:)]) {
        [self.nn_backgroundItemDelegate nn_navigationItem:self backgroundItemChangeForKey:@"nn_backgroundImage"];
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

- (NSMutableDictionary *)nn_backgroundImages {
    NSMutableDictionary *nn_backgroundImages = objc_getAssociatedObject(self, kUINavigationItem_NNBackgroundImages);
    if (!nn_backgroundImages) {
        nn_backgroundImages = [NSMutableDictionary new];
        objc_setAssociatedObject(self, kUINavigationItem_NNBackgroundImages, nn_backgroundImages, OBJC_ASSOCIATION_RETAIN);
    }
    return nn_backgroundImages;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage forBarPosition:(UIBarPosition)barPosition barMetrics:(UIBarMetrics)barMetrics {
    NSString *key = UINavigationItem_NNBackgroundKey(barPosition, barMetrics);
    [[self nn_backgroundImages] setObject:backgroundImage forKey:key];
}

- (UIImage *)backgroundImageForBarPosition:(UIBarPosition)barPosition barMetrics:(UIBarMetrics)barMetrics {
    NSString *key = UINavigationItem_NNBackgroundKey(barPosition, barMetrics);
    return [[self nn_backgroundImages] objectForKey:key];
}

- (void)setBackgroundImage:(UIImage *)backgroundImage forBarMetrics:(UIBarMetrics)barMetrics {
    UIBarPosition barPosition = UIBarPositionAny;
    [self setBackgroundImage:backgroundImage forBarPosition:barPosition barMetrics:barMetrics];
}

- (UIImage *)backgroundImageForBarMetrics:(UIBarMetrics)barMetrics {
    UIBarPosition barPosition = UIBarPositionAny;
    return [self backgroundImageForBarPosition:barPosition barMetrics:barMetrics];
}

- (void)setBackgroundColor:(nullable UIColor *)backgroundColor forBarPosition:(UIBarPosition)barPosition barMetrics:(UIBarMetrics)barMetrics {
    NSString *key = UINavigationItem_NNBackgroundKey(barPosition, barMetrics);
    [[self nn_backgroundColors] setObject:backgroundColor forKey:key];
}
- (nullable UIColor *)backgroundColorForBarPosition:(UIBarPosition)barPosition barMetrics:(UIBarMetrics)barMetrics {
    NSString *key = UINavigationItem_NNBackgroundKey(barPosition, barMetrics);
    return [[self nn_backgroundColors] objectForKey:key];
}

- (void)setBackgroundColor:(nullable UIColor *)backgroundColor forBarMetrics:(UIBarMetrics)barMetrics {
    UIBarPosition barPosition = UIBarPositionAny;
    [self setBackgroundColor:backgroundColor forBarPosition:barPosition barMetrics:barMetrics];
}

- (nullable UIColor *)backgroundColorForBarPosition:(UIBarMetrics)barMetrics {
    UIBarPosition barPosition = UIBarPositionAny;
    return [self backgroundColorForBarPosition:barPosition barMetrics:barMetrics];
}

@end
