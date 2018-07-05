//
//  EasySequenceTests.m
//  EasySequenceTests
//
//  Created by William Zang on 04/20/2018.
//  Copyright (c) 2018 Beijing Sankuai Online Technology Co.,Ltd (Meituan)
//

@import Foundation;
@import Quick;
@import Nimble;

#import <EasySequence/EasySequence.h>

QuickSpecBegin(EZSequenceSpec)

describe(@"EZSequence behaivors", ^{
    
    context(@"Creating", ^{
        it(@"can be created by using `EZS_Sequence` or `EZS_SequenceWithType` macro.", ^{
            NSArray *array = @[@1, @2, @3];
            EZSequence *sequence = EZS_Sequence(array);
            expect(sequence).to(beAKindOf(EZSequence.class));
            EZSequence<NSNumber *> *sequenceWithGeneric = EZS_SequenceWithType(NSNumber *, array);
            expect(sequenceWithGeneric).to(beAKindOf(EZSequence.class));
        });
        
        it(@"can be created by using `EZS_asSequence`.", ^{
            EZSequence *sequence = [@[@1, @2, @3] EZS_asSequence];
            expect(sequence).to(beAKindOf(EZSequence.class));
        });
        
        it(@"support generics.", ^{
            EZSequence<NSNumber *> *sequence = [[EZSequence alloc] initWithOriginSequence:@[@1, @2, @3]];
            NSMutableArray *receive = [NSMutableArray array];
            [sequence forEach:^(NSNumber *item) {
                [receive addObject:item];
            }];
            expect(receive).to(equal(@[@1, @2, @3]));
        });
    });
    
    context(@"Enumerating", ^{
        it(@"can enumerate using fast enumeration.", ^{
            EZSequence *sequence = [[EZSequence alloc] initWithOriginSequence:@[@1, @2, @3]];
            NSMutableArray *receive = [NSMutableArray array];
            for (id item in sequence) {
                [receive addObject:item];
            }
            expect(receive).to(equal(@[@1, @2, @3]));
        });
        
        it(@"can enumerate using block-based enumeration.", ^{
            EZSequence *sequence = [[EZSequence alloc] initWithOriginSequence:@[@1, @2, @3]];
            NSMutableArray *receive = [NSMutableArray array];
            [sequence forEach:^(id item) {
                [receive addObject:item];
            }];
            expect(receive).to(equal(@[@1, @2, @3]));
        });

        it(@"can enumerate using NSEnumerator.", ^{
            {
                EZSequence<NSNumber *> *sequence = [[EZSequence alloc] initWithOriginSequence:@[@1, @2, @3]];
                NSMutableArray<NSNumber *> *receive = [NSMutableArray array];
                
                NSEnumerator<NSNumber *> *enumerator = [sequence objectEnumerator];
                for (id item in enumerator) {
                    [receive addObject:item];
                }
                expect(receive).to(equal(@[@1, @2, @3]));
            }
            {
                NSMutableSet *largeSet = [NSMutableSet set];
                NSMutableSet *receiveSet = [NSMutableSet set];
                for (int i = 0; i < 999; ++i) {
                    [largeSet addObject:@(i)];
                }
                EZSequence<NSNumber *> *sequence = EZS_Sequence(largeSet);
                NSEnumerator<NSNumber *> *enumerator = sequence.objectEnumerator;
                for (id item in enumerator) {
                    [receiveSet addObject:item];
                }
                expect(receiveSet).to(equal(largeSet));
            }
        });
    });
    
    context(@"comparing", ^{
        it(@"can compare with another `EZSequence`.", ^{
            EZSequence *sequence1 = [[EZSequence alloc] initWithOriginSequence:@[@1, @2, @3]];
            EZSequence *sequence2 = [[EZSequence alloc] initWithOriginSequence:[NSOrderedSet orderedSetWithObjects:@1, @2, @3, nil]];
            expect(sequence1).to(equal(sequence2));
            // EZSequence 实例可以作为 isEqual 的左侧判断值，右侧使用任意的NSFastEnumeration协议对象都可以判断
            // 反之则不行
            expect(sequence1).to(equal(@[@1, @2, @3]));
            expect(@[@1, @2, @3]).notTo(equal(sequence2));
            sequence1 = [[EZSequence alloc] initWithOriginSequence:@[@4, @5, @6]];
            sequence2 = [[EZSequence alloc] initWithOriginSequence:[NSOrderedSet orderedSetWithObjects:@7, @8, @9, nil]];
            expect(sequence1).notTo(equal(sequence2));
        });
    });

    context(@"EZSTransfer", ^{
        it(@"can be transform to a `NSArray`", ^{
            EZSequence *sequence = [[EZSequence alloc] initWithOriginSequence:@[@1, @2, @3]];
            NSArray *array = [sequence as:NSArray.class];
            expect(array).to(beAKindOf(NSArray.class));
            expect(array).to(equal(@[@1, @2, @3]));
        });
        
        it(@"can be tranform to a `NSSet`", ^{
            EZSequence *sequence = [[EZSequence alloc] initWithOriginSequence:@[@1, @2, @3, @2]];
            NSSet *set = [sequence as:NSSet.class];
            expect(set).to(beAKindOf(NSSet.class));
            expect(set).to(equal([NSSet setWithObjects:@1, @2, @3, nil]));
        });
        
        it(@"can be tranform to a `NSOrderedSet`", ^{
            EZSequence *sequence = [[EZSequence alloc] initWithOriginSequence:@[@1, @2, @3, @2]];
            NSOrderedSet *orderSet = [sequence as:NSOrderedSet.class];
            expect(orderSet).to(beAKindOf(NSOrderedSet.class));
            expect(orderSet).to(equal([NSOrderedSet orderedSetWithArray:@[@1, @2, @3]]));
        });
        
        it(@"can be transform to a `EZSArray`", ^{
            EZSequence *sequence = [[EZSequence alloc] initWithOriginSequence:@[@1, @2, @3]];
            EZSArray *array = [sequence as:EZSArray.class];
            expect(array).to(beAKindOf(EZSArray.class));
            expect(array).to(equal(@[@1, @2, @3]));
        });

        it(@"can be transform to a `EZSWeakArray`", ^{
            EZSequence *sequence = [[EZSequence alloc] initWithOriginSequence:@[@1, @2, @3]];
            EZSWeakArray *array = [sequence as:EZSWeakArray.class];
            expect(array).to(beAKindOf(EZSWeakArray.class));
            expect(array).to(equal(@[@1, @2, @3]));
        });

        it(@"can be transform to a `EZSOrderedSet`", ^{
            EZSequence *sequence = [[EZSequence alloc] initWithOriginSequence:@[@1, @2, @3]];
            EZSOrderedSet *set = [sequence as:EZSOrderedSet.class];
            expect(set).to(beAKindOf(EZSOrderedSet.class));
            expect(set.allObjects).to(equal(@[@1, @2, @3]));
        });
        
        it(@"can be transform to a `EZSWeakOrderedSet`", ^{
            EZSequence *sequence = [[EZSequence alloc] initWithOriginSequence:@[@1, @2, @3]];
            EZSWeakOrderedSet *set = [sequence as:EZSWeakOrderedSet.class];
            expect(set).to(beAKindOf(EZSWeakOrderedSet.class));
            expect(set.allObjects).to(equal(@[@1, @2, @3]));
        });
        
    });
});

QuickSpecEnd
