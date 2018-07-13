//
//  EZSEnumeratorSpec.m
//  iOSTest
//
//  Created by William Zang on 2018/7/13.
//  Copyright (c) 2018 Beijing Sankuai Online Technology Co.,Ltd (Meituan)
//

@import Foundation;
@import Quick;
@import Nimble;

#import <EasySequence/EasySequence.h>

QuickSpecBegin(EZSEnumberatorSpec)

describe(@"EZSEnumerator", ^{
    it(@"can create an enumerator from an id<NSFastEnumeration>", ^{
        id<NSFastEnumeration> fastEnumeration = @[@1, @2, @3];
        NSEnumerator *enumerator = [[EZSEnumerator alloc] initWithFastEnumerator:fastEnumeration];
        expect(enumerator).toNot(beNil());
        expect(enumerator).to(beAKindOf(EZSEnumerator.class));
    });
    
    it(@"can enumerate any id<NSFastEnumeration>", ^{
        NSMutableSet *set = [NSMutableSet set];
        for (int i = 0; i < 999; ++i) {
            [set addObject:@(i)];
        }
        NSEnumerator *enumerator = [[EZSEnumerator alloc] initWithFastEnumerator:set];
        NSMutableDictionary *enumerated = [NSMutableDictionary dictionary];
        NSNumber *value = enumerator.nextObject;
        while (value) {
            enumerated[value] = @YES;
            value = enumerator.nextObject;
        }
        expect(enumerated.allKeys).to(haveCount(999));
        for (int i = 0; i < 999; ++i) {
            expect(enumerated[@(i)]).to(equal(@YES));
        }
    });
});

QuickSpecEnd
