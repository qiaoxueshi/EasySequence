//
//  EZSEnumerator.h
//  EasySequence
//
//  Created by nero on 2018/4/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 `EZSEnumerator`是一个迭代器，用于遍历。
 */
@interface EZSEnumerator : NSEnumerator

/**
 从一个实现了快读遍历协议的对象得到一个迭代器。

 @param fastEnumerator 实现了`NSFastEnumeration`协议的对象
 @return 迭代器实例
 */
- (instancetype)initWithFastEnumerator:(id<NSFastEnumeration>)fastEnumerator;

@end

NS_ASSUME_NONNULL_END
