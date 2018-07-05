//
//  EXPMatchers+beEmpty.m
//  EasyReact
//
//  Created by Chengwei Zang on 2017/5/28.
//  Copyright (c) 2018 Beijing Sankuai Online Technology Co.,Ltd (Meituan)
//



//id<NMBMatcher> beEmptyValue() {
//    return [NMBObjCMatcher beEmptyValueMatcher];
//}
//
//id<NMBMatcher> receive(NSArray *arr) {
//    return [NMBObjCMatcher receiveMatcher:arr];
//}
//
id<NMBMatcher> beReleasedCorrectly() {
    return [NMBObjCMatcher beReleasedCorrectlyMatcher];
}

id<NMBMatcher> hasParameterAssert(void) {
    return [NMBObjCMatcher hasParameterAssertMatcher];
}

id<NMBMatcher> hasAssert(void) {
    return [NMBObjCMatcher hasAssertMatcher];
}
