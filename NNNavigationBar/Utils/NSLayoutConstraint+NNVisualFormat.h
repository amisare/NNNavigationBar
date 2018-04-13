//
//  NSLayoutConstraint+NNVisualFormat.h
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/13.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSLayoutConstraint (NNVisualFormat)

+ (NSArray<__kindof NSLayoutConstraint *> *)nn_constraintsWithVisualFormats:(NSArray *)formats views:(NSDictionary<NSString *, id> *)views;

@end
