//
//  NSObject+EZSequence.h
//  EasySequence
//
//  Created by William Zang on 2018/4/24.
//

#import <Foundation/Foundation.h>

@class EZSequence;

@interface NSObject (EZSequence)

/**
 从对象得到一个EZSequence实例。
 Note: 对象必须实现`NSFastEnumeration`协议

 @return 一个EZSequence实例
 */
- (EZSequence *)EZS_asSequence;

@end
