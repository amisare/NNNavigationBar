//
//  NNAnimatedImageView.h
//  NNAnimatedImageView
//
//  Created by GuHaijun on 2018/4/27.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NNAnimatedImageView : UIView

@property (nonatomic, strong) UIImage *nn_image;
@property (nonatomic, strong) UIImage *nn_toImage;
@property (nonatomic, assign, getter=nn_isAnimating) BOOL nn_animating;
@property (nonatomic, assign, getter=nn_isReversed) BOOL nn_reversed;
@property (nonatomic, assign) CGFloat nn_animationProcess;
@property (nonatomic, assign) NSTimeInterval nn_animationDuration;
@property (nonatomic, assign) NSTimeInterval nn_frameDuration;
@property (nonatomic, assign) CGFloat nn_animationProcessing;

@end
