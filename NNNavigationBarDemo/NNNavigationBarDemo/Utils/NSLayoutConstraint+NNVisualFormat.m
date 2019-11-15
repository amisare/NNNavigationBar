//
//  NSLayoutConstraint+NNVisualFormat.m
//  NNNavigationBar
//
//  Created by GuHaijun on 2018/4/13.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "NSLayoutConstraint+NNVisualFormat.h"

@implementation NSLayoutConstraint (NNVisualFormat)

+ (NSArray<__kindof NSLayoutConstraint *> *)nn_constraintsWithVisualFormats:(NSArray *)formats views:(NSDictionary<NSString *, id> *)views {
    
    NSMutableArray *constraints = [NSMutableArray new];
    
    for (id _format in formats) {
        NSString *format = @"";
        NSLayoutFormatOptions options = 0;
        NSDictionary<NSString *,id> * metrics = nil;
        
        if (![_format isKindOfClass:[NSString class]] &&
            ![_format isKindOfClass:[NSDictionary class]]) {
            continue;
        }
        
        if ([_format isKindOfClass:[NSString class]]) {
            format = _format;
        }
        
        if ([_format isKindOfClass:[NSDictionary class]]) {
            format = [[_format objectForKey:@"format"] length] ? [_format objectForKey:@"format"] : @"";
            options = [[_format objectForKey:@"options"] unsignedIntegerValue];
            metrics = [_format objectForKey:@"metrics"];
        }
        
        [constraints addObjectsFromArray:[self constraintsWithVisualFormat:format options:options metrics:metrics views:views]];
    }
    
    return constraints;
}

@end
