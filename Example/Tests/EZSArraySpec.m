//
//  EZSArraySpec.m
//  iOSTest
//
//  Created by Qin Hong on 4/28/18.
//  Copyright (c) 2018 Beijing Sankuai Online Technology Co.,Ltd (Meituan)
//

@import Foundation;
@import Quick;
@import Nimble;


QuickSpecBegin(EZSArraySpec)

describe(@"EZSArray", ^{
    context(@"initializing", ^{
        it(@"can be initialized", ^{
            EZSArray *arr = [[EZSArray alloc] init];
            expect(arr).notTo(beNil());
            expect(arr.count).to(equal(0));
        });

        it(@"can be initialized from an NSArray", ^{
            NSArray *array = @[@"1", @"2", @"3", @"4"];
            EZSArray *arr = [[EZSArray alloc] initWithNSArray:array];
            expect(arr).notTo(beNil());
            expect(arr.count).to(equal(4));
            expect(arr).to(equal(array));
        });
    });
    
    context(@"enumerating", ^{        
        it(@"can enumerate using fast enumeration.", ^{
            NSMutableArray *nsarr = [NSMutableArray array];
            for (int i = 0; i < 999; i++) {
                [nsarr addObject:@(i)];
            }
            EZSArray *arr = [[EZSArray alloc] initWithNSArray:nsarr];
            NSMutableArray *receive = [NSMutableArray array];
            for (id item in arr) {
                [receive addObject:item];
            }
            
            expect(receive).to(equal(nsarr));
        });
    });
    
    context(@"modify", ^{
        it(@"can get an object at index", ^{
            NSArray *array = @[@"1", @"2", @"3", @"4"];
            EZSArray *arr = [[EZSArray alloc] initWithNSArray:array];
            expect(arr.count).to(equal(4));
            expect(arr).to(equal(@[@"1", @"2", @"3", @"4"]));
        });
        
        it(@"can add an object", ^{
            NSArray *array = @[@"1", @"2", @"3", @"4"];
            EZSArray *arr = [[EZSArray alloc] initWithNSArray:array];
            [arr addObject:@"5"];
            expect(arr.count).to(equal(5));
            expect([arr objectAtIndex:4]).to(equal(@"5"));
            [arr addObject:@"6"];
            expect(arr.count).to(equal(6));
            [arr addObject:@"7"];
            expect(arr.count).to(equal(7));
            expect([arr objectAtIndex:5]).to(equal(@"6"));
            expect([arr objectAtIndex:6]).to(equal(@"7"));
        });
        
        it(@"can insert an object at index", ^{
            NSArray *array = @[@"1", @"2", @"3", @"4"];
            EZSArray *arr = [[EZSArray alloc] initWithNSArray:array];
            [arr insertObject:@"i" atIndex:2];
            expect(arr.count).to(equal(5));
            expect(arr).to(equal(@[@"1", @"2", @"i", @"3", @"4"]));
        });
        
        it(@"can remove the specified object", ^{
            NSArray *array = @[@"1", @"2", @"3", @"4"];
            EZSArray *arr = [[EZSArray alloc] initWithNSArray:array];
            [arr removeObject:@"3"];
            expect(arr.count).to(equal(3));
            expect(arr).to(equal(@[@"1", @"2", @"4"]));

            [arr removeObject:@"8"];
            expect(arr.count).to(equal(3));
            expect(arr).to(equal(@[@"1", @"2", @"4"]));
        });
        
        it(@"can remove the last object", ^{
            NSArray *array = @[@"1", @"2", @"3", @"4"];
            EZSArray *arr = [[EZSArray alloc] initWithNSArray:array];
            [arr removeLastObject];
            expect(arr.count).to(equal(3));
            expect(arr).to(equal(@[@"1", @"2", @"3"]));
        });
        
        it(@"can remove the first object", ^{
            NSArray *array = @[@"1", @"2", @"3", @"4"];
            EZSArray *arr = [[EZSArray alloc] initWithNSArray:array];
            [arr removeFirstObject];
            expect(arr.count).to(equal(3));
            expect(arr).to(equal(@[@"2", @"3", @"4"]));
        });
        
        it(@"can remove an object at index", ^{
            NSArray *array = @[@"1", @"2", @"3", @"4"];
            EZSArray *arr = [[EZSArray alloc] initWithNSArray:array];
            [arr removeObjectAtIndex:2];
            expect(arr.count).to(equal(3));
            expect(arr).to(equal(@[@"1", @"2", @"4"]));
        });
        
        it(@"can remove all objects", ^{
            NSArray *array = @[@"1", @"2", @"3", @"4"];
            EZSArray *arr = [[EZSArray alloc] initWithNSArray:array];
            expect(arr.count).to(equal(4));
            expect(arr).to(equal(@[@"1", @"2", @"3", @"4"]));
            
            [arr removeAllObjects];
            expect(arr.count).to(equal(0));
            expect(arr).to(equal(@[]));
        });
        
        it(@"can replace the object at the index with the new object", ^{
            NSArray *array = @[@"1", @"2", @"3", @"4"];
            EZSArray *arr = [[EZSArray alloc] initWithNSArray:array];
            [arr replaceObjectAtIndex:2 withObject:@"233"];
            expect(arr.count).to(equal(4));
            expect(arr).to(equal(@[@"1", @"2", @"233", @"4"]));
        });
    });
    
    context(@"Accessing Values Using Subscripting", ^{
        it(@"can get the object at the specified index.", ^{
            NSArray *array = @[@"1", @"2", @"3", @"4"];
            EZSArray *arr = [[EZSArray alloc] initWithNSArray:array];
            expect(arr.count).to(equal(4));
            expect(arr[0]).to(equal(@"1"));
            expect(arr[1]).to(equal(@"2"));
            expect(arr[2]).to(equal(@"3"));
            expect(arr[3]).to(equal(@"4"));
        });

        it(@"can set the object at the specified index.", ^{
            NSArray *array = @[@"1", @"2", @"3", @"4"];
            EZSArray *arr = [[EZSArray alloc] initWithNSArray:array];
            expect(arr.count).to(equal(4));
            expect(arr[0]).to(equal(@"1"));
            expect(arr[1]).to(equal(@"2"));
            expect(arr[2]).to(equal(@"3"));
            expect(arr[3]).to(equal(@"4"));
            arr[2] = @"222";
            arr[3] = @"333";
            arr[4] = @"444";
            expect(arr[0]).to(equal(@"1"));
            expect(arr[1]).to(equal(@"2"));
            expect(arr[2]).to(equal(@"222"));
            expect(arr[3]).to(equal(@"333"));
            expect(arr[4]).to(equal(@"444"));
        });
    });
    
    context(@"Memory management", ^{
        it(@"can be released correctly.", ^{
            __weak EZSArray *weakArr = nil;
            @autoreleasepool {
                NSArray *array = @[@"1", @"2", @"3", @"4"];
                EZSArray *arr = [[EZSArray alloc] initWithNSArray:array];
                weakArr = arr;
                expect(arr.count).to(equal(4));
                expect(arr).to(equal(@[@"1", @"2", @"3", @"4"]));
            }
            expect(weakArr).to(beNil());
        });
    });
    
    context(@"NSCopying", ^{
        it(@"can make a copy", ^{
            NSArray *array = @[@"1", @"2", @"3", @"4"];
            EZSArray *arr = [[EZSArray alloc] initWithNSArray:array];
            EZSArray *arrCopy = [arr copy];
            expect(arrCopy.class).to(equal(EZSArray.class));
            expect(arrCopy.count).to(equal(arr.count));
            expect(arrCopy).notTo(beIdenticalTo(arr));
            expect(arrCopy).to(equal(arr));
            expect(arrCopy).to(equal(array));
            expect(arr).to(equal(array));
            
            [arrCopy addObject:@"5"];
            expect(arr).to(equal(array));
            expect(arrCopy).to(equal(@[@"1", @"2", @"3", @"4", @"5"]));
        });
    });
});

QuickSpecEnd
