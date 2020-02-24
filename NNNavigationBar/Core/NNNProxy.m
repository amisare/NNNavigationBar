//
//  NNProxy.m
//  NNNavigationBar
//
//  Created by GuHaijun on 2019/7/19.
//  Copyright © 2019 GuHaijun. All rights reserved.
//

#import "NNNProxy.h"

@implementation NNNProxy

+ (instancetype)proxyWithTarget:(id)target{
    return [[self alloc] initWithTarget:target];
}

- (instancetype)initWithTarget:(id)target{
    _target = target;
    return self;
}

- (BOOL)respondsToSelector:(SEL)aSelector{
    return [self.target respondsToSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    return [self.target methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)invocation{
    SEL sel = [invocation selector];
    if ([self.target respondsToSelector:sel]) {
        [invocation invokeWithTarget:self.target];
    }
}

@end
