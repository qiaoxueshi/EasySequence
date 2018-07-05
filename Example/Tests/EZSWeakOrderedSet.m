//
//  EZSWeakOrderedSet.m
//  iOSTest
//
//  Created by Qin Hong on 5/2/18.
//  Copyright (c) 2018 Beijing Sankuai Online Technology Co.,Ltd (Meituan)
//

@import Foundation;
@import Quick;
@import Nimble;

#import <EasySequence/EasySequence.h>

QuickSpecBegin(EZSWeakOrderedSetSpec)

describe(@"EZSWeakOrderedSet", ^{

    context(@"initializing", ^{
        it(@"can be initialized", ^{
            EZSWeakOrderedSet *set = [[EZSWeakOrderedSet alloc] init];
            expect(set).notTo(beNil());
            expect(set.count).to(equal(0));
        });
        
        it(@"can be initialized from an NSArray", ^{
            NSArray *arr = @[@"2", @"0", @"1", @"8", @"1"];
            EZSWeakOrderedSet *set = [[EZSWeakOrderedSet alloc] initWithNSArray:arr];
     
            NSArray *resultArray = @[@"2", @"0", @"1", @"8"];
            NSOrderedSet *resultSet = [NSOrderedSet orderedSetWithArray:resultArray];
            expect(set.count).to(equal(4));
            expect(set).to(equal(resultSet));
            expect(set.allObjects).to(equal(resultArray));
        });
        
        it(@"can be initialized from an NSSet", ^{
            NSOrderedSet *origSet = [[NSOrderedSet alloc] initWithObjects:@"2", @"0", @"1", @"8", @"1",  nil];
            EZSWeakOrderedSet *set = [[EZSWeakOrderedSet alloc] initWithNSOrderedSet:origSet];
            expect(set).notTo(beNil());
            expect(set.count).to(equal(4));
            
            NSArray *resultArray = @[@"2", @"0", @"1", @"8"];
            NSOrderedSet *resultSet = [NSOrderedSet orderedSetWithArray:resultArray];
            expect(set).to(equal(resultSet));
            expect(set.allObjects).to(equal(resultArray));
        });
        
        
        it(@"can automic remove dealloced object from set", ^{
            EZSWeakOrderedSet *set;
            NSObject *strongObject1;
            NSObject *strongObject2;
            __weak NSObject *weakObject1;
            __weak NSObject *weakObject2;
            
            @autoreleasepool {
                @autoreleasepool {
                    strongObject1 = [NSObject new];
                    strongObject2 = [NSObject new];
                    NSObject *innerStrongObject1 = [NSObject new];
                    NSObject *innerStrongObject2 = [NSObject new];
                    weakObject1 = innerStrongObject1;
                    weakObject2 = innerStrongObject2;
                    
                    set = [[EZSWeakOrderedSet alloc] initWithNSArray:@[strongObject1, strongObject2, weakObject1, weakObject2]];
                    
                    expect(set).notTo(beNil());
                    expect(set.count).to(equal(4));
                }
            }
            
            expect(set.count).to(equal(2));
            NSArray *resultArray = @[strongObject1, strongObject2];
            NSOrderedSet *resultSet = [NSOrderedSet orderedSetWithArray:resultArray];
            expect(set).to(equal(resultSet));
            expect(set.allObjects).to(equal(resultArray));
        });
    });
    
    context(@"enumerating", ^{
        it(@"can enumerate using fast enumeration.", ^{
            NSMutableArray *arr = [NSMutableArray array];
            for (int i = 0; i < 999; i++) {
                [arr addObject:@(i)];
            }
            EZSWeakOrderedSet *set = [[EZSWeakOrderedSet alloc] initWithNSArray:arr];
            NSMutableArray *receive = [NSMutableArray array];
            for (id item in set) {
                [receive addObject:item];
            }
            expect(receive).to(equal(arr));
        });
    });

    context(@"modify", ^{
        it(@"can get an object at index", ^{
            EZSWeakOrderedSet *set;
            NSObject *strongObj3;
            @autoreleasepool{
                NSObject *obj1 = [NSObject new];
                NSObject *obj2 = [NSObject new];
                NSObject *obj3 = [NSObject new];
                strongObj3 = obj3;
                NSObject *obj4 = [NSObject new];
                NSArray *array = @[obj1, obj2, strongObj3, obj4];
                set = [[EZSWeakOrderedSet alloc] initWithNSArray:array];
                expect(set.count).to(equal(4));
                expect([set objectAtIndex:0]).to(equal(obj1));
                expect([set objectAtIndex:1]).to(equal(obj2));
                expect([set objectAtIndex:2]).to(equal(obj3));
                expect([set objectAtIndex:3]).to(equal(obj4));
                expect(set.allObjects).to(equal(array));
            }
            expect(set.count).to(equal(1));
            expect([set objectAtIndex:0]).to(equal(strongObj3));
            NSArray *resultArray = @[strongObj3];
            NSOrderedSet *resultSet = [NSOrderedSet orderedSetWithArray:resultArray];
            expect(set).to(equal(resultSet));
            expect(set.allObjects).to(equal(resultArray));
        });
        
        it(@"can add an object", ^{
            EZSWeakOrderedSet *set;
            NSObject *strongObj3;
            @autoreleasepool{
                NSObject *obj1 = [NSObject new];
                NSObject *obj2 = [NSObject new];
                NSObject *obj3 = [NSObject new];
                strongObj3 = obj3;
                NSObject *obj4 = [NSObject new];
                NSArray *array = @[obj1, obj2, strongObj3, obj4];
                set = [[EZSWeakOrderedSet alloc] initWithNSArray:array];
                
                NSObject *obj5 = [NSObject new];
                [set addObject:obj5];
                
                expect(set.count).to(equal(5));
                expect([set objectAtIndex:4]).to(equal(obj5));
                expect(set.allObjects).to(equal(@[obj1, obj2, strongObj3, obj4, obj5]));
            }
            expect(set.count).to(equal(1));
            
            NSObject *obj6 = [NSObject new];
            [set addObject:obj6];
            expect(set.count).to(equal(2));
            expect([set objectAtIndex:1]).to(equal(obj6));
            NSArray *resultArray = @[strongObj3, obj6];
            NSOrderedSet *resultSet = [NSOrderedSet orderedSetWithArray:resultArray];
            expect(set).to(equal(resultSet));
            expect(set.allObjects).to(equal(resultArray));
        });
        
        it(@"can insert an object at index", ^{
            EZSWeakOrderedSet *set;
            NSObject *strongObj3;
            NSObject *strongObj5;
            @autoreleasepool{
                NSObject *obj1 = [NSObject new];
                NSObject *obj2 = [NSObject new];
                NSObject *obj3 = [NSObject new];
                strongObj3 = obj3;
                NSObject *obj4 = [NSObject new];
                NSArray *array = @[obj1, obj2, strongObj3, obj4];
                set = [[EZSWeakOrderedSet alloc] initWithNSArray:array];
                expect(set.count).to(equal(4));
                
                strongObj5 = [NSObject new];
                [set insertObject:strongObj5 atIndex:2];
                expect(set.count).to(equal(5));
                expect([set objectAtIndex:2]).to(equal(strongObj5));
                expect(set.allObjects).to(equal(@[obj1, obj2, strongObj5, strongObj3, obj4]));
                
            }
            expect(set.count).to(equal(2));
            NSArray *resultArray = @[strongObj5, strongObj3];
            NSOrderedSet *resultSet = [NSOrderedSet orderedSetWithArray:resultArray];
            expect(set).to(equal(resultSet));
            expect(set.allObjects).to(equal(resultArray));
            
        });
        
        it(@"can remove the specified object", ^{
            EZSWeakOrderedSet *set;
            NSObject *strongObj3;
            @autoreleasepool{
                NSObject *obj1 = [NSObject new];
                NSObject *obj2 = [NSObject new];
                NSObject *obj3 = [NSObject new];
                strongObj3 = obj3;
                NSObject *obj4 = [NSObject new];
                NSArray *array = @[obj1, obj2, strongObj3, obj4];
                set = [[EZSWeakOrderedSet alloc] initWithNSArray:array];
                
                expect(set.count).to(equal(4));
                expect(set.allObjects).to(equal(@[obj1, obj2, strongObj3, obj4]));
                [set removeObject:obj3];
                expect(set.count).to(equal(3));
                expect(set.allObjects).to(equal(@[obj1, obj2, obj4]));
                
                NSObject *obj5 = [NSObject new];
                [set removeObject:obj5];
                expect(set.count).to(equal(3));
               expect(set.allObjects).to(equal(@[obj1, obj2, obj4]));
            }
            expect(set.count).to(equal(0));
            NSArray *resultArray = @[];
            NSOrderedSet *resultSet = [NSOrderedSet orderedSetWithArray:resultArray];
            expect(set).to(equal(resultSet));
            expect(set.allObjects).to(equal(resultArray));
        });
        
        it(@"can remove the last object", ^{
            NSArray *array = @[@"1", @"2", @"3", @"4"];
            EZSWeakOrderedSet *set = [[EZSWeakOrderedSet alloc] initWithNSArray:array];
            expect(set.count).to(equal(4));
            expect(set.allObjects).to(equal(array));
            [set removeLastObject];
            expect(set.count).to(equal(3));
            NSArray *resultArray = @[@"1", @"2", @"3"];
            NSOrderedSet *resultSet = [NSOrderedSet orderedSetWithArray:resultArray];
            expect(set).to(equal(resultSet));
            expect(set.allObjects).to(equal(resultArray));
        });
        
        it(@"can remove the first object", ^{
            NSArray *array = @[@"1", @"2", @"3", @"4"];
            EZSWeakOrderedSet *set = [[EZSWeakOrderedSet alloc] initWithNSArray:array];
            expect(set.count).to(equal(4));
            expect(set.allObjects).to(equal(array));
            [set removeFirstObject];
            expect(set.count).to(equal(3));
            NSArray *resultArray = @[@"2", @"3", @"4"];
            NSOrderedSet *resultSet = [NSOrderedSet orderedSetWithArray:resultArray];
            expect(set).to(equal(resultSet));
            expect(set.allObjects).to(equal(resultArray));
        });
        
        it(@"can remove an object at index", ^{
            NSArray *array = @[@"1", @"2", @"3", @"4"];
            EZSWeakOrderedSet *set = [[EZSWeakOrderedSet alloc] initWithNSArray:array];
            expect(set.count).to(equal(4));
            expect(set.allObjects).to(equal(array));
            [set removeObjectAtIndex:2];
            expect(set.count).to(equal(3));
            NSArray *resultArray = @[@"1", @"2", @"4"];
            NSOrderedSet *resultSet = [NSOrderedSet orderedSetWithArray:resultArray];
            expect(set).to(equal(resultSet));
            expect(set.allObjects).to(equal(resultArray));
        });
        
        it(@"can remove all objects", ^{
            NSArray *array = @[@"1", @"2", @"3", @"4"];
            EZSWeakOrderedSet *set = [[EZSWeakOrderedSet alloc] initWithNSArray:array];
            expect(set.count).to(equal(4));
            expect(set).to(equal([NSOrderedSet orderedSetWithArray:array]));
        
            [set removeAllObjects];
            expect(set.count).to(equal(0));
            expect(set).to(equal([NSOrderedSet orderedSet]));
        });
        
        it(@"can replace the object at the index with the new object", ^{
            NSArray *array = @[@"1", @"2", @"3", @"4"];
            EZSWeakOrderedSet *set = [[EZSWeakOrderedSet alloc] initWithNSArray:array];
            expect(set.count).to(equal(4));
            expect(set.allObjects).to(equal(array));
            [set replaceObjectAtIndex:2 withObject:@"233"];
            expect(set.count).to(equal(4));
            NSArray *resultArray = @[@"1", @"2", @"233", @"4"];
            NSOrderedSet *resultSet = [NSOrderedSet orderedSetWithArray:resultArray];
            expect(set).to(equal(resultSet));
           expect(set.allObjects).to(equal(resultArray));
        });
    });
    
    context(@"Accessing Values Using Subscripting", ^{
        it(@"can get the object at the specified index.", ^{
            EZSWeakOrderedSet *set;
            NSObject *strongObj3;
            @autoreleasepool{
                NSObject *obj1 = [NSObject new];
                NSObject *obj2 = [NSObject new];
                NSObject *obj3 = [NSObject new];
                strongObj3 = obj3;
                NSObject *obj4 = [NSObject new];
                NSArray *array = @[obj1, obj2, strongObj3, obj4];
                set = [[EZSWeakOrderedSet alloc] initWithNSArray:array];
                expect(set.count).to(equal(4));
                expect(set[0]).to(equal(obj1));
                expect(set[1]).to(equal(obj2));
                expect(set[2]).to(equal(obj3));
                expect(set[3]).to(equal(obj4));
            }
            expect(set.count).to(equal(1));
            expect(set[0]).to(equal(strongObj3));
        });
        
        it(@"can set the object at the specified index.", ^{
            EZSWeakOrderedSet *set;
            NSObject *strongObj3;
            @autoreleasepool{
                NSObject *obj1 = [NSObject new];
                NSObject *obj2 = [NSObject new];
                NSObject *obj3 = [NSObject new];
                strongObj3 = obj3;
                NSObject *obj4 = [NSObject new];
                NSArray *array = @[obj1, obj2, strongObj3, obj4];
                set = [[EZSWeakOrderedSet alloc] initWithNSArray:array];
                
                NSObject *a = [NSObject new];
                NSObject *b = [NSObject new];
                NSObject *c = [NSObject new];
                set[2] = a;
                set[3] = b;
                set[4] = c;
                expect(set.count).to(equal(5));
                expect(set[0]).to(equal(obj1));
                expect(set[1]).to(equal(obj2));
                expect(set[2]).to(equal(a));
                expect(set[3]).to(equal(b));
                expect(set[4]).to(equal(c));
            }
            expect(set.count).to(equal(0));
        });
    });
    
    context(@"copy test", ^{
        it(@"can make a copy", ^{
            EZSWeakOrderedSet *weakSet;
            EZSWeakOrderedSet *weakSetCopy;
            NSObject *strongObj3;
            NSObject *anotherObject;
            @autoreleasepool {
                NSObject *obj1 = [NSObject new];
                NSObject *obj2 = [NSObject new];
                NSObject *obj3 = [NSObject new];
                strongObj3 = obj3;
                NSObject *obj4 = [NSObject new];
                NSArray *array = @[obj1, obj2, obj3, obj4];
                weakSet = [[EZSWeakOrderedSet alloc] initWithNSArray:array];
                weakSetCopy = [weakSet copy];
                expect(weakSetCopy.class).to(equal(EZSWeakOrderedSet.class));
                expect(weakSetCopy.count).to(equal(weakSet.count));
                expect(weakSetCopy).notTo(beIdenticalTo(weakSet));
                expect(weakSetCopy).to(equal(weakSet));
                
                anotherObject = [NSObject new];
                [weakSetCopy addObject:anotherObject];
                expect(weakSetCopy).notTo(equal(weakSet));

            }
            expect(weakSet.count).to(equal(1));
            expect(weakSetCopy.count).to(equal(2));
        });
    });
    
    context(@"Memory management", ^{
        it(@"can be released correctly.", ^{
            expectCheckTool((^(CheckReleaseTool *checkTool) {
                NSObject *obj1 = [NSObject new];
                NSObject *obj2 = [NSObject new];
                NSObject *obj3 = [NSObject new];
                NSObject *obj4 = [NSObject new];
                NSArray *array = @[obj1, obj2, obj3, obj4];
                EZSWeakOrderedSet *set = [[EZSWeakOrderedSet alloc] initWithNSArray:array];
                [checkTool checkObj:obj1];
                [checkTool checkObj:obj2];
                [checkTool checkObj:obj3];
                [checkTool checkObj:obj4];
                [checkTool checkObj:set];
            })).to(beReleasedCorrectly());
         
        });
    });
});

QuickSpecEnd
