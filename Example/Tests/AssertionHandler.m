//
//  AssertionHandler.m
//  EasyReact_Tests
//
//  Created by nero on 2017/8/8.
//  Copyright (c) 2018 Beijing Sankuai Online Technology Co.,Ltd (Meituan)
//

#import "AssertionHandler.h"

@implementation AssertionHandler

- (void)handleFailureInMethod:(SEL)selector object:(id)object file:(NSString *)fileName lineNumber:(NSInteger)line description:(NSString *)format, ... {
    NSException *e =  [NSException exceptionWithName:NSStringFromSelector(selector)
                                              reason:format
                                            userInfo:nil];
    if ([format hasPrefix: @"Invalid parameter not satisfying:"]) {
        self.parameterAssertExecption = e;
    } else {
        self.assertExecption = e;
    }
}

- (void)handleFailureInFunction:(NSString *)functionName file:(NSString *)fileName lineNumber:(NSInteger)line description:(NSString *)format, ... {
    NSException *e = [NSException exceptionWithName:functionName
                                             reason:format
                                           userInfo:nil];
    if ([format hasPrefix: @"Invalid parameter not satisfying:"]) {
        self.parameterAssertExecption = e;
    } else {
        self.assertExecption = e;
    }
}

@end
