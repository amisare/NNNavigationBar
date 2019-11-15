//
//  NNFadeAnimationImageView.h
//  NNFadeAnimationImageView
//
//  Created by GuHaijun on 2018/4/27.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, NNFadeAnimationState) {
    NNFadeAnimationStateStart,
    NNFadeAnimationStatePause,
    NNFadeAnimationStateEnd,
};

@interface NNFadeAnimationImageView : UIView

@property (nonatomic, strong) UIImage *nn_image;
@property (nonatomic, strong) UIImage *nn_toImage;
@property (nonatomic, assign) BOOL nn_hasAnimation;
@property (nonatomic, assign) NSTimeInterval nn_animationDuration;
@property (nonatomic, assign) NSTimeInterval nn_frameDuration;
@property (nonatomic, assign, getter=nn_isReversed) BOOL nn_reversed;
@property (nonatomic, assign) BOOL nn_hasTranslucentEffect;
@property (nonatomic, assign, readonly) BOOL nn_animating;
@property (nonatomic, assign) CGFloat nn_animationProcess;
@property (nonatomic, assign, readonly) CGFloat nn_animationProcessing;
@property (nonatomic, assign) NNFadeAnimationState nn_animationState;

@end
