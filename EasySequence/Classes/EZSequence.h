//
//  EZSequence.h
//  EasySequence
//
//  Created by William Zang on 2018/4/20.
//

#import <Foundation/Foundation.h>

@protocol EZSTransfer;

NS_ASSUME_NONNULL_BEGIN

@interface EZSequence<T> : NSObject <NSFastEnumeration>

/**
 从一个实现了`NSFastEnumeration`的对象初始化出一个序列。

 @param originSequence 实现了`NSFastEnumeration`协议的对象
 @return EZSequence实例
 */
- (instancetype)initWithOriginSequence:(id<NSFastEnumeration>)originSequence;

/**
 对象反转，即EZSequence转换为任意实现了`EZSTransfer`协议的对象。
 
 @param clazz 实现了`EZSTransfer`的对象的Class
 @return EZSequence实例
 */
- (id)as:(Class<EZSTransfer>)clazz;

/**
 带有停止功能的遍历
 
 @param eachBlock 遍历block, 入参为：
 - item: 遍历到的元素
 - index: 遍历到的下标
 - stop: 值为YES时停止遍历
 */
- (void)forEachWithIndexAndStop:(void (NS_NOESCAPE ^)(T item, NSUInteger index, BOOL *stop))eachBlock;

/**
 返回正序迭代器

 @return 迭代器对象
 */
- (NSEnumerator<T> *)objectEnumerator;

@end

NS_ASSUME_NONNULL_END

#define EZS_Sequence(...)                        [[EZSequence alloc] initWithOriginSequence:__VA_ARGS__]
#define EZS_SequenceWithType(__type__, ...)      ((EZSequence<__type__> *)EZS_Sequence(__VA_ARGS__))

