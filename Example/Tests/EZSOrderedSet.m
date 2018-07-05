//
//  EZSOrderedSet.m
//  iOSTest
//
//  Created by Qin Hong on 5/2/18.
//  Copyright (c) 2018 Beijing Sankuai Online Technology Co.,Ltd (Meituan)
//

@import Foundation;
@import Quick;
@import Nimble;

#import <EasySequence/EasySequence.h>

QuickSpecBegin(EZSOrderedSetSpec)

describe(@"EZSOrderedSet", ^{
    context(@"initializing", ^{
        it(@"can be initialized", ^{
            EZSOrderedSet *set = [[EZSOrderedSet alloc] init];
            expect(set).notTo(beNil());
            expect(set.count).to(equal(0));
            NSOrderedSet *emptySet = [NSOrderedSet orderedSet];
            expect(set).to(equal(emptySet));
            expect([set allObjects]).to(equal(@[]));
            
        });

        it(@"can be initialized from an NSArray", ^{
            NSArray *arr = @[@"2", @"0", @"1", @"8", @"1"];
            EZSOrderedSet *set = [[EZSOrderedSet alloc] initWithNSArray:arr];
            expect(set).notTo(beNil());
            expect([set count]).to(equal(4));
            NSArray *resultArray = @[@"2", @"0", @"1", @"8"];
            NSOrderedSet *resultSet = [NSOrderedSet orderedSetWithArray:resultArray];
            expect(set).to(equal(resultSet));
            expect([set allObjects]).to(equal(resultArray));
            
        });

        it(@"can be initialized from an NSOrderedSet", ^{
            NSOrderedSet *origSet = [[NSOrderedSet alloc] initWithObjects:@"2", @"0", @"1", @"8", @"1",  nil];
            EZSOrderedSet *set = [[EZSOrderedSet alloc] initWithNSOrderedSet:origSet];
            expect(set).notTo(beNil());
            expect(set.count).to(equal(4));
            expect(set).to(equal(origSet));
            expect([set allObjects]).to(equal(@[@"2", @"0", @"1", @"8"]));

        });
    });
    
    context(@"enumerating", ^{
        it(@"can enumerate using fast enumeration.", ^{
            NSMutableArray *arr = [NSMutableArray array];
            for (int i = 0; i < 999; i++) {
                [arr addObject:@(i)];
            }
            EZSOrderedSet *set = [[EZSOrderedSet alloc] initWithNSArray:arr];
            NSMutableArray *receive = [NSMutableArray array];
            for (id item in set) {
                [receive addObject:item];
            }
            expect(receive).to(equal(arr));
        });
    });

    context(@"modify", ^{
        it(@"can get an object at index", ^{
            NSArray *array = @[@"1", @"2", @"3", @"4", @"1"];
            EZSOrderedSet *set = [[EZSOrderedSet alloc] initWithNSArray:array];
            expect(set.count).to(equal(4));
            expect([set objectAtIndex:0]).to(equal(@"1"));
            expect([set objectAtIndex:1]).to(equal(@"2"));
            expect([set objectAtIndex:2]).to(equal(@"3"));
            expect([set objectAtIndex:3]).to(equal(@"4"));
        });
        
        it(@"can add an object", ^{
            NSArray *array = @[];
            EZSOrderedSet *set = [[EZSOrderedSet alloc] initWithNSArray:array];

            [set addObject:@"5"];
            expect(set.count).to(equal(1));
            expect([set objectAtIndex:0]).to(equal(@"5"));
            [set addObject:@"6"];
            expect(set.count).to(equal(2));
            [set addObject:@"7"];
            expect(set.count).to(equal(3));
            expect([set objectAtIndex:1]).to(equal(@"6"));
            expect([set objectAtIndex:2]).to(equal(@"7"));
        });
        
        it(@"can insert an object at index", ^{
            NSArray *array = @[@"1", @"2", @"3", @"4"];
            EZSOrderedSet *set = [[EZSOrderedSet alloc] initWithNSArray:array];
            [set insertObject:@"i" atIndex:2];
            expect(set.count).to(equal(5));
            expect([set objectAtIndex:0]).to(equal(@"1"));
            expect([set objectAtIndex:1]).to(equal(@"2"));
            expect([set objectAtIndex:2]).to(equal(@"i"));
            expect([set objectAtIndex:3]).to(equal(@"3"));
            expect([set objectAtIndex:4]).to(equal(@"4"));
        });
        
        it(@"can remove the specified object", ^{
            NSArray *array = @[@"1", @"2", @"3", @"4"];
            EZSOrderedSet *set = [[EZSOrderedSet alloc] initWithNSArray:array];
            [set removeObject:@"3"];
            [set removeObject:@"8"];
            expect(set.count).to(equal(3));
            expect([set objectAtIndex:0]).to(equal(@"1"));
            expect([set objectAtIndex:1]).to(equal(@"2"));
            expect([set objectAtIndex:2]).to(equal(@"4"));
        });
        
        it(@"can remove the last object", ^{
            NSArray *array = @[@"1", @"2", @"3", @"4"];
            EZSOrderedSet *set = [[EZSOrderedSet alloc] initWithNSArray:array];
            [set removeLastObject];
            expect(set.count).to(equal(3));
            expect([set objectAtIndex:0]).to(equal(@"1"));
            expect([set objectAtIndex:1]).to(equal(@"2"));
            expect([set objectAtIndex:2]).to(equal(@"3"));
        });
        
        it(@"can remove the first object", ^{
            NSArray *array = @[@"1", @"2", @"3", @"4"];
            EZSOrderedSet *set = [[EZSOrderedSet alloc] initWithNSArray:array];
            [set removeFirstObject];
            expect(set.count).to(equal(3));
            expect([set objectAtIndex:0]).to(equal(@"2"));
            expect([set objectAtIndex:1]).to(equal(@"3"));
            expect([set objectAtIndex:2]).to(equal(@"4"));
        });
        
        it(@"can remove an object at index", ^{
            NSArray *array = @[@"1", @"2", @"3", @"4"];
            EZSOrderedSet *set = [[EZSOrderedSet alloc] initWithNSArray:array];

            [set removeObjectAtIndex:2];
            expect(set.count).to(equal(3));
            expect([set objectAtIndex:0]).to(equal(@"1"));
            expect([set objectAtIndex:1]).to(equal(@"2"));
            expect([set objectAtIndex:2]).to(equal(@"4"));
        });
        
        it(@"can replace the object at the index with the new object", ^{
            NSArray *array = @[@"1", @"2", @"3", @"4"];
            EZSOrderedSet *set = [[EZSOrderedSet alloc] initWithNSArray:array];
            [set replaceObjectAtIndex:2 withObject:@"233"];
            expect(set.count).to(equal(4));
            expect([set objectAtIndex:0]).to(equal(@"1"));
            expect([set objectAtIndex:1]).to(equal(@"2"));
            expect([set objectAtIndex:2]).to(equal(@"233"));
            expect([set objectAtIndex:3]).to(equal(@"4"));
        });
    });
    
    context(@"copy test", ^{
        it(@"can get a copyed object for original set", ^{
            NSOrderedSet *nsset = [[NSOrderedSet alloc] initWithObjects:@"2", @"0", @"1", @"8", @"1",  nil];
            EZSOrderedSet *set = [[EZSOrderedSet alloc] initWithNSOrderedSet:nsset];
            EZSOrderedSet *copyedSet = [set copy];
            expect(copyedSet).notTo(beIdenticalTo(set));
            expect(copyedSet).to(equal(set));
            expect(copyedSet).to(equal(nsset));
            expect(copyedSet.count).to(equal(4));
            expect(copyedSet.class).to(equal([EZSOrderedSet class]));
            
            [copyedSet addObject:@"a"];
            expect(set).to(equal(nsset));
            expect(copyedSet).to(equal([[NSOrderedSet alloc] initWithObjects:@"2", @"0", @"1", @"8", @"1", @"a", nil]));
        });
    });
    
    context(@"Accessing Values Using Subscripting", ^{
        it(@"can get the object at the specified index.", ^{
            NSArray *array = @[@"1", @"2", @"3", @"4"];
            EZSOrderedSet *set = [[EZSOrderedSet alloc] initWithNSArray:array];
            expect(set.count).to(equal(4));
            expect(set[0]).to(equal(@"1"));
            expect(set[1]).to(equal(@"2"));
            expect(set[2]).to(equal(@"3"));
            expect(set[3]).to(equal(@"4"));
        });
        
        it(@"can set the object at the specified index.", ^{
            NSArray *array = @[@"1", @"2", @"3", @"4"];
            EZSOrderedSet *set = [[EZSOrderedSet alloc] initWithNSArray:array];
            set[2] = @"222";
            set[3] = @"333";
            set[4] = @"444";

            expect(set[0]).to(equal(@"1"));
            expect(set[1]).to(equal(@"2"));
            expect(set[2]).to(equal(@"222"));
            expect(set[3]).to(equal(@"333"));
            expect(set[4]).to(equal(@"444"));
        });
    });
});

QuickSpecEnd
