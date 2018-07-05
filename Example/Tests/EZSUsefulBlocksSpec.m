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
    });
});

QuickSpecEnd
