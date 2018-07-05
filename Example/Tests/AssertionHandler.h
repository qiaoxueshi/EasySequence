//
//  AssertionHandler.h
//  EasyReact_Tests
//
//  Created by nero on 2017/8/8.
//  Copyright (c) 2018 Beijing Sankuai Online Technology Co.,Ltd (Meituan)
//

#import <Foundation/Foundation.h>

@interface AssertionHandler : NSAssertionHandler

@property (nonatomic, strong, nullable) NSException *assertExecption;
@property (nonatomic, strong, nullable) NSException *parameterAssertExecption;

@end
