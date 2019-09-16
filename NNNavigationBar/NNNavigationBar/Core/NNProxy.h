//
//  NNProxy.h
//  NNNavigationBar
//
//  Created by GuHaijun on 2019/7/19.
//  Copyright © 2019 GuHaijun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NNProxy : NSProxy

@property (nonatomic, weak, readonly) id target;
+ (instancetype)proxyWithTarget:(id)target;
- (instancetype)initWithTarget:(id)target;

@end
