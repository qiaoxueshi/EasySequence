//
//  EZSWeakArraySpec.m
//  iOSTest
//
//  Created by Qin Hong on 4/28/18.
//  Copyright (c) 2018 Beijing Sankuai Online Technology Co.,Ltd (Meituan)
//

@import Foundation;
@import Quick;
@import Nimble;

QuickSpecBegin(EZSWeakArraySpec)

describe(@"EZSWeakArray", ^{
    context(@"initializing", ^{
        it(@"can be initialized", ^{
            EZSWeakArray *arr = [[EZSWeakArray alloc] init];
            expect(arr).notTo(beNil());
            expect(arr.count).to(equal(0));
        });
        
        it(@"can be initialized from an NSArray", ^{
            NSArray *array = @[@"1", @"2", @"3", @"4"];
            EZSWeakArray *arr = [[EZSWeakArray alloc] initWithNSArray:array];
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
            EZSWeakArray *arr = [[EZSWeakArray alloc] initWithNSArray:nsarr];
            NSMutableArray *receive = [NSMutableArray array];
            for (id item in arr) {
                [receive addObject:item];
            }
            
            expect(receive).to(equal(nsarr));
        });
    });
    
    context(@"query", ^{
        it(@"can check whether an object exists in array", ^{
            NSObject *obj1 = [NSObject new];
            NSObject *obj2 = [NSObject new];
            NSObject *obj3 = [NSObject new];

            NSArray *array = @[obj1, obj2];
            EZSWeakArray *arr = [[EZSWeakArray alloc] initWithNSArray:array];
            expect([arr containsObject:obj1]).to(equal(YES));
            expect([arr containsObject:obj3]).to(equal(NO));
        });
        
        it(@"can get the position of an object", ^{
            NSObject *obj1 = [NSObject new];
            NSObject *obj2 = [NSObject new];
            NSObject *obj3 = [NSObject new];
            
            NSArray *array = @[obj1, obj2];
            EZSWeakArray *arr = [[EZSWeakArray alloc] initWithNSArray:array];
            expect([arr indexOfObject:obj1]).to(equal(0));
            expect([arr indexOfObject:obj3]).to(equal(NSNotFound));
        });
    });
    
    context(@"modify", ^{
        it(@"can get an object at index", ^{
            EZSWeakArray *arr;
            NSObject *strongObj3;
            @autoreleasepool{
                NSObject *obj1 = [NSObject new];
                NSObject *obj2 = [NSObject new];
                NSObject *obj3 = [NSObject new];
                strongObj3 = obj3;
                NSObject *obj4 = [NSObject new];
                NSArray *array = @[obj1, obj2, strongObj3, obj4];
                arr = [[EZSWeakArray alloc] initWithNSArray:array];
                expect(arr.count).to(equal(4));
                expect(arr).to(equal(@[obj1, obj2, obj3, obj4]));
            }
            expect(arr.count).to(equal(1));
        });
        
        it(@"can add an object", ^{
            EZSWeakArray *arr;
            NSObject *strongObj3;
            @autoreleasepool{
                NSObject *obj1 = [NSObject new];
                NSObject *obj2 = [NSObject new];
                NSObject *obj3 = [NSObject new];
                strongObj3 = obj3;
                NSObject *obj4 = [NSObject new];
                NSArray *array = @[obj1, obj2, strongObj3, obj4];
                arr = [[EZSWeakArray alloc] initWithNSArray:array];
                
                NSObject *obj5 = [NSObject new];
                [arr addObject:obj5];
                expect(arr.count).to(equal(5));
                expect([arr objectAtIndex:4]).to(equal(obj5));
            }
            expect(arr.count).to(equal(1));
            
            NSObject *obj6 = [NSObject new];
            [arr addObject:obj6];
            expect(arr.count).to(equal(2));
            expect([arr objectAtIndex:1]).to(equal(obj6));
        });
        
        it(@"can insert an object at index", ^{
            EZSWeakArray *arr;
            NSObject *strongObj3;
            @autoreleasepool{
                NSObject *obj1 = [NSObject new];
                NSObject *obj2 = [NSObject new];
                NSObject *obj3 = [NSObject new];
                strongObj3 = obj3;
                NSObject *obj4 = [NSObject new];
                NSArray *array = @[obj1, obj2, strongObj3, obj4];
                arr = [[EZSWeakArray alloc] initWithNSArray:array];
                expect(arr.count).to(equal(4));
                
                NSObject *obj5 = [NSObject new];
                [arr insertObject:obj5 atIndex:2];
                expect(arr.count).to(equal(5));
                expect(arr).to(equal(@[obj1, obj2, obj5, obj3, obj4]));
            }
            expect(arr.count).to(equal(1));
        });
        
        it(@"can remove the specified object", ^{
            EZSWeakArray *arr;
            NSObject *strongObj3;
            @autoreleasepool{
                NSObject *obj1 = [NSObject new];
                NSObject *obj2 = [NSObject new];
                NSObject *obj3 = [NSObject new];
                strongObj3 = obj3;
                NSObject *obj4 = [NSObject new];
                NSArray *array = @[obj1, obj2, strongObj3, obj4];
                arr = [[EZSWeakArray alloc] initWithNSArray:array];
                expect(arr.count).to(equal(4));

                [arr removeObject:obj3];
                expect(arr.count).to(equal(3));

                NSObject *obj5 = [NSObject new];
                [arr removeObject:obj5];
                expect(arr.count).to(equal(3));
                expect(arr).to(equal(@[obj1, obj2, obj4]));
            }
            expect(arr.count).to(equal(0));
        });
        
        it(@"can remove the last object", ^{
            EZSWeakArray *arr;
            NSObject *strongObj3;
            @autoreleasepool{
                NSObject *obj1 = [NSObject new];
                NSObject *obj2 = [NSObject new];
                NSObject *obj3 = [NSObject new];
                strongObj3 = obj3;
                NSObject *obj4 = [NSObject new];
                NSArray *array = @[obj1, obj2, strongObj3, obj4];
                arr = [[EZSWeakArray alloc] initWithNSArray:array];
                expect(arr.count).to(equal(4));
                
                [arr removeLastObject];
                expect(arr.count).to(equal(3));
                expect(arr).to(equal(@[obj1, obj2, obj3]));

                [arr removeLastObject];
                expect(arr.count).to(equal(2));
                [arr removeLastObject];
                expect(arr.count).to(equal(1));
                [arr removeLastObject];
                expect(arr.count).to(equal(0));
                [arr removeLastObject];
                expect(arr.count).to(equal(0));
            }
            expect(arr.count).to(equal(0));
        });
        
        it(@"can remove the first object", ^{
            EZSWeakArray *arr;
            NSObject *strongObj3;
            @autoreleasepool{
                NSObject *obj1 = [NSObject new];
                NSObject *obj2 = [NSObject new];
                NSObject *obj3 = [NSObject new];
                strongObj3 = obj3;
                NSObject *obj4 = [NSObject new];
                NSArray *array = @[obj1, obj2, strongObj3, obj4];
                arr = [[EZSWeakArray alloc] initWithNSArray:array];
                expect(arr.count).to(equal(4));
                
                [arr removeFirstObject];
                expect(arr.count).to(equal(3));
                expect(arr).to(equal(@[obj2, obj3, obj4]));
                
                [arr removeFirstObject];
                expect(arr.count).to(equal(2));
                expect(arr).to(equal(@[obj3, obj4]));
                [arr removeFirstObject];
                expect(arr.count).to(equal(1));
                [arr removeFirstObject];
                expect(arr.count).to(equal(0));
                [arr removeFirstObject];
                expect(arr.count).to(equal(0));
            }
            expect(arr.count).to(equal(0));
        });
        
        it(@"can remove an object at index", ^{
            EZSWeakArray *arr;
            NSObject *strongObj3;
            @autoreleasepool{
                NSObject *obj1 = [NSObject new];
                NSObject *obj2 = [NSObject new];
                NSObject *obj3 = [NSObject new];
                strongObj3 = obj3;
                NSObject *obj4 = [NSObject new];
                NSArray *array = @[obj1, obj2, strongObj3, obj4];
                arr = [[EZSWeakArray alloc] initWithNSArray:array];
                expect(arr.count).to(equal(4));
                
                [arr removeObjectAtIndex:1];
                expect(arr.count).to(equal(3));
                expect(arr).to(equal(@[obj1, obj3, obj4]));
                
                [arr removeObjectAtIndex:2];
                expect(arr.count).to(equal(2));
                expect(arr).to(equal(@[obj1, obj3]));
            }
            expect(arr.count).to(equal(1));
        });
        
        it(@"can remove all objects", ^{
            EZSWeakArray *arr;
            NSObject *strongObj3;
            @autoreleasepool{
                NSObject *obj1 = [NSObject new];
                NSObject *obj2 = [NSObject new];
                NSObject *obj3 = [NSObject new];
                strongObj3 = obj3;
                NSObject *obj4 = [NSObject new];
                NSArray *array = @[obj1, obj2, strongObj3, obj4];
                arr = [[EZSWeakArray alloc] initWithNSArray:array];
                expect(arr.count).to(equal(4));
                expect(arr).to(equal(@[obj1, obj2, obj3, obj4]));
                
                [arr removeAllObjects];
                expect(arr.count).to(equal(0));
                expect(arr).to(equal(@[]));
            }
            expect(arr.count).to(equal(0));
            expect(arr).to(equal(@[]));
        });
        
        it(@"can replace the object at the index with the new object", ^{
            EZSWeakArray *arr;
            NSObject *strongObj3;
            @autoreleasepool{
                NSObject *obj1 = [NSObject new];
                NSObject *obj2 = [NSObject new];
                NSObject *obj3 = [NSObject new];
                strongObj3 = obj3;
                NSObject *obj4 = [NSObject new];
                NSArray *array = @[obj1, obj2, strongObj3, obj4];
                arr = [[EZSWeakArray alloc] initWithNSArray:array];
                expect(arr.count).to(equal(4));
                
                NSObject *a = [NSObject new];
                [arr replaceObjectAtIndex:2 withObject:a];
                expect(arr.count).to(equal(4));
                expect(arr).to(equal(@[obj1, obj2, a, obj4]));
            }
            expect(arr.count).to(equal(0));
        });
    });
    
    context(@"Accessing Values Using Subscripting", ^{
        it(@"can get the object at the specified index.", ^{
            EZSWeakArray *arr;
            NSObject *strongObj3;
            @autoreleasepool{
                NSObject *obj1 = [NSObject new];
                NSObject *obj2 = [NSObject new];
                NSObject *obj3 = [NSObject new];
                strongObj3 = obj3;
                NSObject *obj4 = [NSObject new];
                NSArray *array = @[obj1, obj2, strongObj3, obj4];
                arr = [[EZSWeakArray alloc] initWithNSArray:array];
                expect(arr.count).to(equal(4));
                expect(arr[0]).to(equal(obj1));
                expect(arr[1]).to(equal(obj2));
                expect(arr[2]).to(equal(obj3));
                expect(arr[3]).to(equal(obj4));
            }
            expect(arr.count).to(equal(1));
        });
        
        it(@"can set the object at the specified index.", ^{
            EZSWeakArray *arr;
            NSObject *strongObj3;
            @autoreleasepool{
                NSObject *obj1 = [NSObject new];
                NSObject *obj2 = [NSObject new];
                NSObject *obj3 = [NSObject new];
                strongObj3 = obj3;
                NSObject *obj4 = [NSObject new];
                NSArray *array = @[obj1, obj2, strongObj3, obj4];
                arr = [[EZSWeakArray alloc] initWithNSArray:array];
                
                NSObject *a = [NSObject new];
                NSObject *b = [NSObject new];
                NSObject *c = [NSObject new];
                arr[2] = a;
                arr[3] = b;
                arr[4] = c;
                expect(arr.count).to(equal(5));
                expect(arr[0]).to(equal(obj1));
                expect(arr[1]).to(equal(obj2));
                expect(arr[2]).to(equal(a));
                expect(arr[3]).to(equal(b));
                expect(arr[4]).to(equal(c));
            }
            expect(arr.count).to(equal(0));
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
                EZSWeakArray *weakarray = [[EZSWeakArray alloc] initWithNSArray:array];
                [checkTool checkObj:obj1];
                [checkTool checkObj:obj2];
                [checkTool checkObj:obj3];
                [checkTool checkObj:obj4];
                [checkTool checkObj:weakarray];
            })).to(beReleasedCorrectly());
        });
    });
    
    context(@"NSCopying", ^{
        it(@"can make a copy", ^{
            EZSWeakArray *weakArray;
            EZSWeakArray *weakArrayCopy;
            NSObject *strongObj3;
            NSObject *anotherObject;
            @autoreleasepool {
                NSObject *obj1 = [NSObject new];
                NSObject *obj2 = [NSObject new];
                NSObject *obj3 = [NSObject new];
                strongObj3 = obj3;
                NSObject *obj4 = [NSObject new];
                NSArray *array = @[obj1, obj2, obj3, obj4];
                weakArray = [[EZSWeakArray alloc] initWithNSArray:array];
                weakArrayCopy = [weakArray copy];
                expect(weakArrayCopy.class).to(equal(EZSWeakArray.class));
                expect(weakArrayCopy.count).to(equal(weakArray.count));
                expect(weakArrayCopy).notTo(beIdenticalTo(weakArray));
                expect(weakArrayCopy).to(equal(weakArray));
                expect(weakArrayCopy).to(equal(array));
                expect(weakArray).to(equal(array));
                
                anotherObject = [NSObject new];
                [weakArrayCopy addObject:anotherObject];
                expect(weakArrayCopy).notTo(equal(weakArray));
            }
            expect(weakArray.count).to(equal(1));
            expect(weakArrayCopy.count).to(equal(2));
        });
    });

});
QuickSpecEnd
