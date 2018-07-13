//
//  EZSWeakReferenceSpec.m
//  iOSTest
//
//  Created by William Zang on 2018/7/13.
//  Copyright (c) 2018 Beijing Sankuai Online Technology Co.,Ltd (Meituan)
//

@import Foundation;
@import Quick;
@import Nimble;

#import <EasySequence/EasySequence.h>

QuickSpecBegin(EZSWeakReferenceSpec)

describe(@"EZSWeakReference", ^{
    it(@"can create an object's reference", ^{
        NSObject *object = [NSObject new];
        EZSWeakReference *reference = [EZSWeakReference reference:object];
        expect(reference).toNot(beNil());
        expect(reference).to(beAKindOf(EZSWeakReference.class));
        expect(reference.reference).to(beIdenticalTo(object));
    });
    
    it(@"has a property named reference, it is a weak property", ^{
        EZSWeakReference *reference;
        @autoreleasepool {
            NSObject *object = [NSObject new];
            reference = [EZSWeakReference reference:object];
            expect(reference.reference).to(beIdenticalTo(object));
            object = nil;
        }
        expect(reference.reference).to(beNil());
    });
    
    it(@"can check equal within two weak reference", ^{
        NSObject *object1 = [NSObject new];
        NSObject *object2 = @"STRING";
        NSMutableString *object3 = [NSMutableString new];
        [object3 appendString:@"STRING"];
        NSObject *object4 = nil;
        EZSWeakReference *reference1 = [EZSWeakReference reference:object1];
        EZSWeakReference *reference2 = [EZSWeakReference reference:object1];
        expect(reference1).to(equal(reference2));
        reference1 = [EZSWeakReference reference:object4];
        reference2 = [EZSWeakReference reference:object4];
        expect(reference1).to(equal(reference2));
        reference1 = [EZSWeakReference reference:object1];
        reference2 = [EZSWeakReference reference:object3];
        expect(reference1).notTo(equal(reference2));
        reference1 = [EZSWeakReference reference:object2];
        reference2 = [EZSWeakReference reference:object3];
        expect(reference1).to(equal(reference2));
    });
    
    it(@"has a hash value equal reference's first hash value", ^{
        NSObject *object1 = @"STRING";
        EZSWeakReference *reference = [EZSWeakReference reference:object1];
        expect(@(reference.hash)).to(equal(@(object1.hash)));
        NSMutableString *object2 = [NSMutableString new];
        [object2 appendString:@"STRING"];
        reference = [EZSWeakReference reference:object2];
        expect(@(reference.hash)).to(equal(@(object2.hash)));
        [object2 appendString:@"STRING"];
        expect(@(reference.hash)).notTo(equal(@(object2.hash)));
    });
    
    it(@"has a description equal reference's description", ^{
        NSObject *object1 = @"STRING";
        EZSWeakReference *reference = [EZSWeakReference reference:object1];
        expect(reference.description).to(equal(object1.description));
    });
    
    it(@"has attach a callback block to a weak reference", ^{
        __block BOOL invoked = NO;
        @autoreleasepool {
            NSObject *object = [NSObject new];
            __block EZSWeakReference *reference;
            reference = [[EZSWeakReference alloc] initWithReference:object deallocBlock:^(EZSWeakReference * _Nonnull insideReference) {
                invoked = YES;
                expect(insideReference).to(beIdenticalTo(reference));
            }];
            object = nil;
        }
        expect(invoked).to(beTrue());
    });
});

QuickSpecEnd
