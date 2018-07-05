//
//  EZSTransfer.h
//  EasySequence
//
//  Created by William Zang on 2018/4/24.
//

#import <Foundation/Foundation.h>

@class EZSequence;

/**
 转换协议，一个类如果实现了此协议，即可得到一个由EZSequence转换来的本类的实例。
 */
@protocol EZSTransfer <NSObject>

/**
 从一个EZSequence转换，得到一个对象。

 @param sequence 要转换的EZSequence
 @return 一个对象实例
 */
+ (instancetype)transferFromSequence:(EZSequence *)sequence;

@end
