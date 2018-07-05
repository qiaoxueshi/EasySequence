//
//  EZSUsefulBlocksSpec.m
//  iOSTest
//
//  Created by nero on 2018/5/2.
//  Copyright (c) 2018 Beijing Sankuai Online Technology Co.,Ltd (Meituan)
//

@import Quick;
@import Nimble;

QuickSpecBegin(EZSUsefulBlocksSpec)

describe(@"EZSUsefulBlocks test", ^{
    context(@"filter useful blocks", ^{
        context(@"is Kind of Class", ^{
            it(@"can generate a block to detemine that whether an object is kind of a specific class", ^{
                EZSFliterBlock isString = EZS_isKindOf_([NSString class]);
                BOOL result1 = isString(@"abc");
                BOOL result2 = isString(@111);
                expect(result1).to(beTrue());
                expect(result2).to(beFalse());
                
                EZSFliterBlock isNumber = EZS_isKindOf_([NSNumber class]);
                NSArray *array = @[@"aa", @123, @"bb", @"cc", @100];
                EZSequence<NSNumber *> *numbers = [EZS_Sequence(array) select:isNumber];
                expect(numbers).to(equal(@[@123,@100]));
            });
            
            it(@"can generate a block to detemine that whether an object is kind of a specific class use macro easyily", ^{
                EZSFliterBlock isString = EZS_isKindOf(NSString);
                BOOL result1 = isString(@"abc");
                BOOL result2 = isString(@111);
                expect(result1).to(beTrue());
                expect(result2).to(beFalse());
                
                EZSFliterBlock isNumber = EZS_isKindOf(NSNumber);
                NSArray *array = @[@"aa", @123, @"bb", @"cc", @100];
                EZSequence<NSNumber *> *numbers = [EZS_Sequence(array) select:isNumber];
                expect(numbers).to(equal(@[@123,@100]));
            });
        });
        
        it(@"can generate a block to detemine that whether an object is equal to something", ^{
            EZSFliterBlock isBad = EZS_isEqual(@"bad");
            NSArray *array = @[@"great", @"bad", @"good", @"bad", @"average", @"unknown"];
            EZSequence<NSNumber *> *result1 = [EZS_Sequence(array)  reject:isBad];
            expect(result1).to(equal(@[@"great", @"good", @"average", @"unknown"]));
            
            EZSFliterBlock isExpectedDic = EZS_isEqual(@{@"status": @1, @"result": @"great"});
            BOOL result2 = isExpectedDic(@{@"status": @1, @"result": @"great"});
            BOOL result3 = isExpectedDic(@{@"status": @0, @"result": @"failed"});
            expect(result2).to(beTrue());
            expect(result3).to(beFalse());
        });
        
        it(@"can generate a block to detemine that whether anthing happen it always return yes", ^{
            EZSFliterBlock alwayYesFilterBlocks = EZS_isExists();
            BOOL result = alwayYesFilterBlocks(@YES);
            expect(result).to(beTrue());
            result = alwayYesFilterBlocks(@NO);
            expect(result).to(beTrue());
        });

        
        it(@"can make a negative version of a given EZSFliterBlock", ^{
            EZSFliterBlock isGood = EZS_isEqual(@"good");
            EZSFliterBlock notGood = EZS_not(isGood);
            BOOL result1 = notGood(@"good");
            BOOL result2 = notGood(@"bad");
            expect(result1).to(beFalse());
            expect(result2).to(beTrue());
            
            NSArray *array = @[@"good", @"bad", @"unknown"];
            EZSequence<NSNumber *> *result3 = [EZS_Sequence(array) reject:notGood];
            expect(result3).to(equal(@[@"good"]));
        });
    });
    
    context(@"map useful blocks", ^{
        it(@"can generate a block to get value for key from object", ^{
            EZSMapBlock mapNameBlock1 = EZS_propertyWith(@"name");
            EZSMapBlock mapNameBlock2 = EZS_propertyWith(EZS_KeyPath(TestObject, name));
            TestObject *t1 = [TestObject new];
            t1.name = @"t1";
            TestObject *t2 = [TestObject new];
            t2.name = @"t2";
            
            NSArray<TestObject *> *array = @[t1, t2];
            EZSequence<NSString *> *result1 = [EZS_Sequence(array) map:mapNameBlock1];
            expect(result1).to(equal(@[@"t1", @"t2"]));
            EZSequence<NSString *> *result2 = [EZS_Sequence(array) map:mapNameBlock2];
            expect(result2).to(equal(@[@"t1", @"t2"]));
        });
        
        it(@"can generate a block to get value for key from dictionary", ^{
            EZSMapBlock mapNameBlock = EZS_valueWithKey(@"key");
            NSArray *array = @[@{@"key": @"value1"}, @{@"key": @"value2"}];
            EZSequence<NSString *> *result = [EZS_Sequence(array) map:mapNameBlock];
            expect(result).to(equal(@[@"value1", @"value2"]));
        });
        
        it(@"should raise a assert when EZS_valueWithKey receive not kind of NSDictionary class ", ^{
            EZSMapBlock mapNameBlock = EZS_valueWithKey(@"key");
            NSArray *array = @[@{@"key": @"value1"}, @{@"key": @"value2"}];
            
            assertExpect(^{
                EZSequence<NSString *> *result __attribute__((unused))= [EZS_Sequence(array) map:mapNameBlock];
            }).to(hasAssert());
        });
        
        it(@"can map item to the result that item execute the selector", ^{
            EZSequence *seq = [@[@"a", @"b", @"c"] EZS_asSequence];
            EZSequence *mappedSeq = [seq map:EZS_mapWithSelector(@selector(uppercaseString))];
            expect(mappedSeq).to(equal(@[@"A", @"B", @"C"]));
        });
        
        it(@"can map item to the result that item execute the selector with one argument", ^{
            EZSequence *seq = [@[@"1", @"22", @"333", @"4444"] EZS_asSequence];
            EZSequence *mappedSeq = [seq map:EZS_mapWithSelector1(@selector(stringByAppendingString:), @"a")];
            expect(mappedSeq).to(equal(@[@"1a", @"22a", @"333a", @"4444a"]));
        });

        it(@"can map item to the result that item execute the selector with two arguments", ^{
            EZSequence *seq = [@[@"1a", @"22a", @"333a", @"4444a"] EZS_asSequence];
            EZSequence *mappedSeq = [seq map:EZS_mapWithSelector2(@selector(stringByReplacingOccurrencesOfString:withString:), @"a", @"b")];
            expect(mappedSeq).to(equal(@[@"1b", @"22b", @"333b", @"4444b"]));
        });
    });
    
    context(@"perform useful blocks", ^{
        it(@"can perform a selector", ^{
            UIView *container = [[UIView alloc] initWithFrame:CGRectZero];
            UIView *view1 = [[UIView alloc] initWithFrame:CGRectZero];
            UIView *view2 = [[UIView alloc] initWithFrame:CGRectZero];
            UIView *view3 = [[UIView alloc] initWithFrame:CGRectZero];
            [container addSubview:view1];
            [container addSubview:view2];
            [container addSubview:view3];
            EZSequence *seq = [container.subviews EZS_asSequence];
            expect(container.subviews.count).to(equal(3));
            [seq forEach:EZS_performSelector(@selector(removeFromSuperview))];
            expect(container.subviews.count).to(equal(0));
        });
        
        it(@"can perform a selector with one argument", ^{
            UIView *view1 = [[UIView alloc] initWithFrame:CGRectZero];
            UIView *view2 = [[UIView alloc] initWithFrame:CGRectZero];
            UIView *view3 = [[UIView alloc] initWithFrame:CGRectZero];
            EZSequence *seq = [@[view1, view2, view3] EZS_asSequence];
            [seq forEach:EZS_performSelector1(@selector(setBackgroundColor:), [UIColor redColor])];
            expect(view1.backgroundColor).to(equal([UIColor redColor]));
            expect(view2.backgroundColor).to(equal([UIColor redColor]));
            expect(view3.backgroundColor).to(equal([UIColor redColor]));
        });

        it(@"can perform a selector with two arguments", ^{
            NSMutableDictionary *dict1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"value1", @"key1", @"valueA", @"keyA", nil];
            NSMutableDictionary *dict2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"value2", @"key1", @"valueB", @"keyB", nil];
            NSMutableDictionary *dict3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"value3", @"key1", @"valueC", @"keyC", nil];
            EZSequence *seq = [@[dict1, dict2, dict3] EZS_asSequence];
            [seq forEach:EZS_performSelector2(@selector(setObject:forKey:), @"newValue", @"key1")];
            expect([dict1 objectForKey:@"key1"]).to(equal(@"newValue"));
            expect([dict2 objectForKey:@"key1"]).to(equal(@"newValue"));
            expect([dict3 objectForKey:@"key1"]).to(equal(@"newValue"));
        });
    });
});

QuickSpecEnd
