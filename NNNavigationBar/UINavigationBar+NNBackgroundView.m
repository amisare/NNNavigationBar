//
//  UINavigationBar+NNBackgroundView.m
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/11.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "UINavigationBar+NNBackgroundView.h"
#import <objc/runtime.h>
#import "UIImage+NNImageWithColor.h"
#import "NSLayoutConstraint+NNVisualFormat.h"
#import "UINavigationBar+NNBackgroundImageView.h"
#import "UINavigationBar+NNBackgroundBarDelegate.h"
#import "UINavigationBar+NNBackgroundDelegateImp.h"
#import "UINavigationItem+NNBackgroundItemDelegate.h"

static const void *kUINavigationBar_NNBackgroundColors = &kUINavigationBar_NNBackgroundColors;
static const void *kUINavigationBar_NNBackgroundImages = &kUINavigationBar_NNBackgroundImages;
static const void *kUINavigationBar_NNBackgroundViewHidden = &kUINavigationBar_NNBackgroundViewHidden;
static const void *kUINavigationBar_NNBackgroundView = &kUINavigationBar_NNBackgroundView;

@interface _NNNavigationBarBackgroundView : UIImageView @end
@implementation _NNNavigationBarBackgroundView @end

#define UINavigationItem_NNBackgroundKey(barPosition, barMetrics) [@(barPosition << (sizeof(barPosition) * 8 / 2) | barMetrics) stringValue]


@implementation UINavigationBar (NNBackgroundView)

- (BOOL)nn_backgroundViewHidden {
    return [objc_getAssociatedObject(self, kUINavigationBar_NNBackgroundViewHidden) boolValue];
}

- (void)setNn_backgroundViewHidden:(BOOL)nn_backgroundViewHidden {
    
    objc_setAssociatedObject(self, kUINavigationBar_NNBackgroundViewHidden, @(nn_backgroundViewHidden), OBJC_ASSOCIATION_RETAIN);
    if (!nn_backgroundViewHidden) {
        UIView *backgroundView = [self valueForKey:@"_backgroundView"];
        if (backgroundView && ![backgroundView.subviews containsObject:self.nn_backgroundView]) {
            [backgroundView addSubview:self.nn_backgroundView];
            
            NSArray<NSLayoutConstraint *> *(^makeViewConstraint)(NSDictionary *view) = ^(NSDictionary *view) {
                return [NSLayoutConstraint nn_constraintsWithVisualFormats:@[[NSString stringWithFormat:@"H:|[%@]|", view.allKeys.lastObject] ,
                                                                             [NSString stringWithFormat:@"V:|[%@]|", view.allKeys.lastObject]]
                                                                     views:view];
            };
            [NSLayoutConstraint activateConstraints:makeViewConstraint(@{@"nn_backgroundView" : self.nn_backgroundView})];
        }
    }
    else {
        [self.nn_backgroundView removeFromSuperview];
    }
}

- (UIView *)nn_backgroundView {
    
    UIView *nn_backgroundView = objc_getAssociatedObject(self, kUINavigationBar_NNBackgroundView);
    if (!nn_backgroundView) {
        nn_backgroundView = [_NNNavigationBarBackgroundView new];
        nn_backgroundView.translatesAutoresizingMaskIntoConstraints = false;
        [nn_backgroundView addSubview:self.nn_backgroundImageView];
        [nn_backgroundView addSubview:self.nn_backgroundAssistantImageView];
        [nn_backgroundView addSubview:self.nn_backgroundDisplayImageView];
        
        NSArray<NSLayoutConstraint *> *(^makeViewConstraint)(NSDictionary *view) = ^(NSDictionary *view) {
            return [NSLayoutConstraint nn_constraintsWithVisualFormats:@[[NSString stringWithFormat:@"H:|[%@]|", view.allKeys.lastObject] ,
                                                                         [NSString stringWithFormat:@"V:|[%@]|", view.allKeys.lastObject]]
                                                                 views:view];
        };
        
        [NSLayoutConstraint activateConstraints:makeViewConstraint(@{@"nn_backgroundImageView" : self.nn_backgroundImageView})];
        [NSLayoutConstraint activateConstraints:makeViewConstraint(@{@"nn_backgroundAssistantImageView" : self.nn_backgroundAssistantImageView})];
        [NSLayoutConstraint activateConstraints:makeViewConstraint(@{@"nn_backgroundDisplayImageView" : self.nn_backgroundDisplayImageView})];
        
        objc_setAssociatedObject(self, kUINavigationBar_NNBackgroundView, nn_backgroundView, OBJC_ASSOCIATION_RETAIN);
        
        self.nn_backgroundBarDelegate = self;
    }
    return nn_backgroundView;
}

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
    if (self.nn_backgroundBarDelegate &&
        [self.nn_backgroundBarDelegate respondsToSelector:@selector(nn_navigationBar:backgroundChangeForKey:)]) {
        [self.nn_backgroundBarDelegate nn_navigationBar:self backgroundChangeForKey:@"nn_backgroundColor"];
    }
}

- (NSMutableDictionary *)nn_backgroundColors {
    NSMutableDictionary *nn_backgroundColors = objc_getAssociatedObject(self, kUINavigationBar_NNBackgroundColors);
    if (!nn_backgroundColors) {
        nn_backgroundColors = [NSMutableDictionary new];
        objc_setAssociatedObject(self, kUINavigationBar_NNBackgroundColors, nn_backgroundColors, OBJC_ASSOCIATION_RETAIN);
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
    if (self.nn_backgroundBarDelegate &&
        [self.nn_backgroundBarDelegate respondsToSelector:@selector(nn_navigationBar:backgroundChangeForKey:)]) {
        [self.nn_backgroundBarDelegate nn_navigationBar:self backgroundChangeForKey:@"nn_backgroundImage"];
    }
}

- (NSMutableDictionary *)nn_backgroundImages {
    NSMutableDictionary *nn_backgroundImages = objc_getAssociatedObject(self, kUINavigationBar_NNBackgroundImages);
    if (!nn_backgroundImages) {
        nn_backgroundImages = [NSMutableDictionary new];
        objc_setAssociatedObject(self, kUINavigationBar_NNBackgroundImages, nn_backgroundImages, OBJC_ASSOCIATION_RETAIN);
    }
    return nn_backgroundImages;
}

@end



