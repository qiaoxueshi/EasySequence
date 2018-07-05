//
//  EXPMatchers+beEmpty.h
//  EasyReact
//
//  Created by Chengwei Zang on 2017/5/28.
//  Copyright (c) 2018 Beijing Sankuai Online Technology Co.,Ltd (Meituan)
//

@import Foundation;
@import Quick;
@import Nimble;
@import EasySequence;
#import "TestObject.h"

//id<NMBMatcher> beEmptyValue(void);
//id<NMBMatcher> receive(NSArray *arr);
id<NMBMatcher> beReleasedCorrectly(void);
id<NMBMatcher> hasParameterAssert(void);
id<NMBMatcher> hasAssert(void);



#define  expectCheckTool(check)                                                                                         \
                CheckReleaseToolBlockContainer *container = [CheckReleaseToolBlockContainer new];                       \
                container.checkReleaseTool = check;                                                                     \
                expect(container)                                                                                       \

#define  assertExpect(block)                                                                                            \
                AssertBlockContainer *container = [AssertBlockContainer new];                                           \
                container.action = block;                                                                               \
                expect(container)                                                                                       \


