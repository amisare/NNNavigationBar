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
    
    for (id _formate in formats) {
        NSString *formate = @"";
        NSLayoutFormatOptions opts = 0;
        NSDictionary<NSString *,id> * metrics = nil;
        
        if ([_formate isKindOfClass:[NSString class]]) {
            formate = _formate;
        }
        
        if ([_formate isKindOfClass:[NSDictionary class]]) {
            formate = [[_formate objectForKey:@"formate"] length] ? [_formate objectForKey:@"formate"] : @"";
            opts = [[_formate objectForKey:@"options"] unsignedIntegerValue];
            metrics = [_formate objectForKey:@"metrics"];
        }
        
        [constraints addObjectsFromArray:[self constraintsWithVisualFormat:formate options:opts metrics:metrics views:views]];
    }
    
    return constraints;
}

@end
