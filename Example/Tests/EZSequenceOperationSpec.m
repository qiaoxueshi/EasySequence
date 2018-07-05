//
//  EZSequenceOperationSpec.m
//  iOSTest
//
//  Created by William Zang on 2018/4/25.
//  Copyright (c) 2018 Beijing Sankuai Online Technology Co.,Ltd (Meituan)
//


QuickSpecBegin(EZSequenceOpertaionSpec)

describe(@"EZSequence Operations", ^{
    it(@"can map an array to a new array by invoking a block on each item", ^{
        EZSequence<NSString *> *sequence = [@[@"111", @"222", @"333"] EZS_asSequence];
        EZSequence<NSNumber *> *mappedSequence = [sequence map:^id _Nonnull(NSString * _Nonnull value) {
            return @(value.integerValue);
        }];
        expect([mappedSequence as:NSArray.class]).to(equal(@[@111, @222, @333]));
    });
    
    it(@"can map an array to a new array with index", ^{
        EZSequence<NSString *> *sequence = [@[@"a", @"b", @"c"] EZS_asSequence];
        EZSequence<NSString *> *mappedSequence = [sequence mapWithIndex:^id _Nonnull(NSString * _Nonnull value, NSUInteger index) {
            return [NSString stringWithFormat:@"%@: %@", @(index), value];
        }];
        expect(mappedSequence).to(equal(@[@"0: a", @"1: b", @"2: c"]));
    });
    
    it(@"can invoke a block on each item of an array with index", ^{
        EZSequence<NSString *> *sequence = [@[@"a", @"bb", @"ccc"] EZS_asSequence];
        NSMutableArray *result = [NSMutableArray array];
        [sequence forEachWithIndex:^(NSString * _Nonnull value, NSUInteger index) {
            [result addObject:[NSString stringWithFormat:@"index: %@, value: %@", @(index), value]];
        }];
        expect(result).to(equal(@[@"index: 0, value: a", @"index: 1, value: bb", @"index: 2, value: ccc"]));
    });
    
    it(@"can invoke a block on items and stop at some point", ^{
        EZSequence<NSString *> *sequence = [@[@"a", @"bb", @"ccc", @"dddd"] EZS_asSequence];
        NSMutableArray *result = [NSMutableArray array];
        [sequence forEachWithIndexAndStop:^(NSString * _Nonnull value, NSUInteger index, BOOL * _Nonnull stop) {
            if (value.length > 2) {
                *stop = YES;
            }
            [result addObject:[NSString stringWithFormat:@"%@ %@", @(index), value]];
        }];
        expect(result).to(equal(@[@"0 a", @"1 bb", @"2 ccc"]));
    });
    
    it(@"can find that whether at least one item in the array meets the given condition", ^{
        EZSequence<NSNumber *> *sequence = [@[@2, @4, @300] EZS_asSequence];
        BOOL containsBigNumber = [sequence any:^BOOL(NSNumber * _Nonnull value) {
            return value.integerValue > 100;
        }];
        expect(containsBigNumber).to(beTrue());
        
        BOOL containsOddNumber = [sequence any:^BOOL(NSNumber * _Nonnull value) {
            return value.integerValue % 2 == 1;
        }];
        expect(containsOddNumber).to(beFalse());
    });
    
    it(@"can return a new array from the origin array which contains the items that meets the given condition", ^{
        EZSequence<NSNumber *> *sequence = [@[@1, @2, @3, @4, @5, @6] EZS_asSequence];
        EZSequence<NSNumber *> *oddNumbers = [sequence select:^BOOL(NSNumber * _Nonnull value) {
            return value.integerValue % 2 == 1;
        }];
        expect(oddNumbers).to(equal(@[@1, @3, @5]));
    });
    
    it(@"can return a new array from the origin array which does not contain the items that meets the given condition", ^{
        EZSequence<NSNumber *> *sequence = [@[@1, @2, @3, @4, @5, @6] EZS_asSequence];
        EZSequence<NSNumber *> *evenNumbers = [sequence reject:^BOOL(NSNumber * _Nonnull value) {
            return value.integerValue % 2 == 1;
        }];
        expect(evenNumbers).to(equal(@[@2, @4, @6]));
    });
    
    it(@"can take some items use `take:` method ", ^{
        {
            EZSequence<NSNumber *> *sequence = [@[@1, @2, @3, @4, @5] EZS_asSequence];
            EZSequence<NSNumber *> *takedSequence = [sequence take:3];
            expect(takedSequence).to(equal(@[@1, @2, @3]));
        }
        {
            EZSequence<NSNumber *> *sequence = [@[@1, @2, @3, @4, @5] EZS_asSequence];
            EZSequence<NSNumber *> *takedSequence = [sequence take:6];
            expect(takedSequence).to(equal(@[@1, @2, @3, @4, @5]));
        }
    });
    
    it(@"can skip some items use `skip:` method", ^{
        {
            EZSequence<NSNumber *> *sequence = [@[@1, @2, @3, @4, @5] EZS_asSequence];
            EZSequence<NSNumber *> *skipedSequence = [sequence skip:3];
            expect(skipedSequence).to(equal(@[@4, @5]));
        }
        {
            EZSequence<NSNumber *> *sequence = [@[@1, @2, @3, @4, @5] EZS_asSequence];
            EZSequence<NSNumber *> *skipedSequence = [sequence skip:6];
            expect(skipedSequence).to(equal(@[]));
        }
    });
    
    it(@"can find first object where conforms predicate", ^{
        EZSequence<NSNumber *> *sequence = [@[@1, @2, @3, @4, @5] EZS_asSequence];
        NSNumber *number = [sequence firstObjectWhere:EZS_isEqual(@3)];
        expect(number).to(equal(@3));
        number = [sequence firstObjectWhere:EZS_isEqual(@100)];
        expect(number).to(beNil());
    });
    
    it(@"can find first index use special object where conforms predicate", ^{
        EZSequence<NSNumber *> *sequence = [@[@1, @2, @3, @4, @5] EZS_asSequence];
        NSUInteger index = [sequence firstIndexWhere:EZS_isEqual(@3)];
        expect(index).to(equal(2));
        index = [sequence firstIndexWhere:EZS_isEqual(@100)];
        expect(index).to(equal(NSNotFound));
    });
    
    it(@"can flatten a highOrder sequence to an normal sequence", ^{
        EZSequence<NSNumber *> *sequence = [@[@1, @2] EZS_asSequence];
        EZSequence<NSNumber *> *flattenedSequence = [sequence flattenMap:^id<NSFastEnumeration> _Nonnull(NSNumber * _Nonnull item) {
            return @[item, @([item integerValue] * 2)];
        }];
        expect(flattenedSequence).to(equal(@[@1, @2, @2, @4]));
    });
    
    it(@"can flatten a highOrder sequence to an normal sequence", ^{
        EZSequence<id<NSFastEnumeration>> *sequence =  EZS_Sequence(@[@[@1, @2], @[@3, @4]]);
        EZSequence<NSNumber *> *flattenedSequence = [sequence flatten];
        expect(flattenedSequence).to(equal(@[@1, @2, @3, @4]));
        
        EZSequence *sequence2 = EZS_Sequence(@[@1, @2, @[@3, @4]]);
        flattenedSequence = [sequence2 flatten];
        expect(flattenedSequence).to(equal(@[@1, @2, @3, @4]));
    });
    
    it(@"should raise exception while flattenMapBlock result is not conforms to NSFastEnumeration", ^{
        EZSequence<NSNumber *> *sequence = [@[@1, @2] EZS_asSequence];
        expectAction(^(){
            __attribute__((unused)) EZSequence<NSNumber *> *flattenedSequence = [sequence flattenMap:^id<NSFastEnumeration> _Nonnull(NSNumber * _Nonnull item) {
                return (id<NSFastEnumeration>)[NSObject new];
            }];
        }).to(raiseException().named(EZSequenceExceptionName).reason(EZSequenceExceptionReason_ResultOfFlattenMapBlockMustConformsNSFastEnumeation));
    });
    
    it(@"can concat with another sequence", ^{
        EZSequence *a = EZS_Sequence(@[@1, @2, @3]);
        EZSequence *result = [a concat:@[@"4", @"5"]];
        expect(result).to(equal(@[@1, @2, @3, @"4", @"5"]));
    });
    
    it(@"can concat with another sequence", ^{
        NSArray *a = @[@1, @2, @3];
        NSArray *b = @[@"4", @"5"];
        NSArray *c = @[@"A", @"B", @"C"];
        EZSequence *result = [EZSequence concatSequences:@[a, b, c]];
        expect(result).to(equal(@[@1, @2, @3, @"4", @"5", @"A", @"B", @"C"]));
    });
    
    context(@"reduce", ^{
        it(@"can reduce an array to a single value using a given block", ^{
            EZSequence<NSNumber *> *sequence1 = [@[@1, @2, @3, @4] EZS_asSequence];
            NSString *result1 = [sequence1 reduce:^id _Nullable(id _Nullable accumulator, NSNumber * _Nonnull item) {
                static dispatch_once_t onceToken;
                dispatch_once(&onceToken, ^{
                    expect(accumulator).to(equal(@1));
                });
                return [NSString stringWithFormat:@"%@+%@", accumulator, item];
            }];
            expect(result1).to(equal(@"1+2+3+4"));
            
            EZSequence *sequence2 = [@[] EZS_asSequence];
            id result2 = [sequence2 reduce:^id _Nullable(id _Nullable accumulator, id _Nonnull item) {
                return [NSString stringWithFormat:@"%@ %@", accumulator, item];
            }];
            expect(result2).to(beNil());
            
            EZSequence<NSString *> *sequence3 = [@[@"aaa"] EZS_asSequence];
            id result3 = [sequence3 reduce:^id _Nullable(id _Nullable accumulator, id _Nonnull item) {
                return [NSString stringWithFormat:@"%@ and %@", accumulator, item];
            }];
            expect(result3).to(equal(@"aaa"));
        });
        
        it(@"can reduce an array to a single value using a given block and a start value", ^{
            EZSequence<NSNumber *> *sequence1 = [@[@1, @2, @3, @4] EZS_asSequence];
            NSNumber *result1 = [sequence1 reduceStart:@5 withBlock:^id _Nullable(id _Nullable accumulator, NSNumber * _Nonnull operand) {
                static dispatch_once_t onceToken;
                dispatch_once(&onceToken, ^{
                    expect(accumulator).to(equal(@5));
                });
                return @([accumulator integerValue] + operand.integerValue);
            }];
            expect(result1).to(equal(@15));
            
            EZSequence *sequence2 = [@[] EZS_asSequence];
            id result2 = [sequence2 reduceStart:nil withBlock:^id _Nullable(id _Nullable accumulator, id _Nonnull operand) {
                return [NSString stringWithFormat:@"%@ %@", accumulator, operand];
            }];
            expect(result2).to(beNil());
            
            EZSequence *sequence3 = [@[] EZS_asSequence];
            id result3 = [sequence3 reduceStart:@"result" withBlock:^id _Nullable(id _Nullable accumulator, id _Nonnull operand) {
                return [NSString stringWithFormat:@"%@ %@", accumulator, operand];
            }];
            expect(result3).to(equal(@"result"));
            
            EZSequence *sequence4 = [@[@"aaa"] EZS_asSequence];
            id result4 = [sequence4 reduceStart:nil withBlock:^id _Nullable(id _Nullable accumulator, id _Nonnull operand) {
                return [NSString stringWithFormat:@"%@ and %@", accumulator, operand];
            }];
            expect(result4).to(equal(@"(null) and aaa"));
        });
    });
    
    context(@"groupBy", ^{
        it(@"can group an array by a given rule", ^{
            NSArray<NSNumber *> *array1 = @[@2, @3, @4, @5, @6, @8];
            NSDictionary *result1 = [EZS_Sequence(array1) groupBy:^id _Nonnull(NSNumber * _Nonnull value) {
                return @(value.integerValue % 3);
            }];
            expect(result1).to(equal(@{@0: @[@3, @6], @1: @[@4], @2:@[@2, @5, @8]}));
            
            NSArray<NSString *> *array2 = @[@"This", @"is", @"a", @"statement", @"."];
            NSDictionary *result2 = [EZS_Sequence(array2) groupBy:^id _Nonnull(NSString * _Nonnull value) {
                return [NSString stringWithFormat:@"length: %@", @(value.length)];
            }];
            expect(result2).to(equal(@{@"length: 1": @[@"a", @"."], @"length: 2": @[@"is"], @"length: 4":@[@"This"], @"length: 9":@[@"statement"]}));
        });
        
        it(@"will return an empty dictionary if the original array is empty", ^{
            NSArray<NSNumber *> *array = @[];
            NSDictionary *grouped = [EZS_Sequence(array) groupBy:^id _Nonnull(NSNumber * _Nonnull value) {
                return @(value.integerValue);
            }];
            expect(grouped).to(equal(@{}));
        });
    });
    
    context(@"zip", ^{
        it(@"can use zip to zip some arrays", ^{
            NSArray *a = @[@1, @2, @3];
            NSArray *b = @[@"a", @"b", @"c"];
            expect([EZSequence zipSequences:@[a, b]]).to(equal(@[@[@1, @"a"], @[@2, @"b"], @[@3, @"c"]]));
            expect([EZS_Sequence(a) zip:b]).to(equal(@[@[@1, @"a"], @[@2, @"b"], @[@3, @"c"]]));
        });
        
        it(@"can use zip to zip some arrays, and support different count", ^{
            NSArray *a = @[@1, @2, @3];
            NSArray *b = @[@"a", @"b"];
            expect([EZSequence zipSequences:@[a, b]]).to(equal(@[@[@1, @"a"], @[@2, @"b"]]));
            expect([EZS_Sequence(a) zip:b]).to(equal(@[@[@1, @"a"], @[@2, @"b"]]));
        });
        
        it(@"should raise exception when use in non-sequence of sequence", ^{
            NSArray *a = @[@1, @2, @3];
            NSString *b = @"b";
            expectAction((^(){
                __attribute__((unused)) EZSequence *zipedSequence = [EZSequence zipSequences:@[a, b]];
            })).to(raiseException().named(EZSequenceExceptionName).reason(EZSequenceExceptionReason_ZipMethodMustUseOnNSFastEnumerationOfNSFastEnumeration));
            expectAction((^(){
                __attribute__((unused)) EZSequence *zipedSequence = [EZS_Sequence(a) zip:(id<NSFastEnumeration>)b];
            })).to(raiseException().named(EZSequenceExceptionName).reason(EZSequenceExceptionReason_ZipMethodMustUseOnNSFastEnumerationOfNSFastEnumeration));
        });
    });
    
    context(@"firstObject", ^{
        it(@"can get first object in a EZSequence", ^{
            EZSequence *seq = EZS_Sequence(@[@"1", @"2", @"3"]);
            expect(seq.firstObject).to(equal(@"1"));
            
            EZSequence *emptySeq = [seq filter:EZS_isEqual(@"4")];
            expect(emptySeq.firstObject).to(beNil());
            
            seq = EZS_Sequence(@[]);
            expect(seq.firstObject).to(beNil());
        });
    });
});


QuickSpecEnd
