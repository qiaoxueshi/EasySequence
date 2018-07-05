//
//  EZSequence+Operations.h
//  EasySequence
//
//  Created by William Zang on 2018/4/20.
//

#import <EasySequence/EZSequence.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN NSString * const EZSequenceExceptionName;
FOUNDATION_EXTERN NSString * const EZSequenceExceptionReason_ResultOfFlattenMapBlockMustConformsNSFastEnumeation;
FOUNDATION_EXTERN NSString * const EZSequenceExceptionReason_ZipMethodMustUseOnNSFastEnumerationOfNSFastEnumeration;

/**
 EZSequence操作
 */
@interface EZSequence<T> (Operations)

/**
 带有index的遍历
 
 @param eachBlock 遍历block, 入参为：
 - item: 遍历到的元素
 - index: 遍历到的下标
 */
- (void)forEachWithIndex:(void (NS_NOESCAPE ^)(T item, NSUInteger index))eachBlock;

/**
 遍历序列
 
 @param eachBlock 遍历block
 - item: 遍历序列时传入的每一个元素
 */
- (void)forEach:(void (NS_NOESCAPE ^)(T item))eachBlock;

/**
 flattenMap操作，返回一个新的序列。

 @param flattenBlock flattenMap Block
 @return 一个新的序列
 */
- (EZSequence *)flattenMap:(id<NSFastEnumeration> (NS_NOESCAPE ^)(T item))flattenBlock;


/**
 过滤操作

 @param filterBlock 过滤block
 @return 一个新的序列，元素为过滤后的元素。
 */
- (EZSequence<T> *)filter:(BOOL (NS_NOESCAPE ^)(T item))filterBlock;

/**
 映射操作

 @param mapBlock 映射block，参数为：
    - item: 元素
 
 @return 一个新的序列，元素为映射后的元素。
 */
- (EZSequence *)map:(id (NS_NOESCAPE ^)(T item))mapBlock;

/**
 映射block中带有Index参数的映射操作
 
 @param mapBlock 映射block，参数为：
    - item: 元素
    - index: 元素下标
 
 @return 一个新的序列，元素为映射后的元素。
 */
- (EZSequence *)mapWithIndex:(id (NS_NOESCAPE ^)(T item, NSUInteger index))mapBlock;

/**
 从一个序列中取前N个元素组成新序列

 @param count 数量
 @return 新序列
 */
- (EZSequence<T> *)take:(NSUInteger)count;

/**
 从一个序列中跳过前N个元素组成新序列

 @param count 数量
 @return 新序列
 */
- (EZSequence<T> *)skip:(NSUInteger)count;

/**
 返回序列中首元素。如EZSequence没有内容，则返回nil

 @return 首个元素
 */
- (nullable T)firstObject;

/**
 从当前序列里找到满足符合条件的元素 如果序列为空或者没找到 则返回nil

 @param checkBlock 判断方法
 @return 符合条件的元素
 */
- (nullable id)firstObjectWhere:(BOOL (NS_NOESCAPE ^)(T item))checkBlock;

/**
 从当前序列里找到满足符合条件的元素 如果序列为空或者没找到 则返回NSNotFound

 @param checkBlock 判断方法
 @return 符合条件的元素
 */
- (NSUInteger)firstIndexWhere:(BOOL (NS_NOESCAPE ^)(T item))checkBlock;

/**
 遍历所有的元素, 返回是否存在元素可以满足checkBlock的条件

 @param checkBlock 需要检查的Block
 @return 是否有元素满足`checkBlock`
 */
- (BOOL)any:(BOOL (NS_NOESCAPE ^)(T item))checkBlock;

/**
 选择操作

 @param selectBlock 选择block, 参数为每一项元素，返回值为一个布尔型，表示此元素是否被选择。
 @return 一个EZSequence实例，元素为选择后的元素
 */
- (EZSequence<T> *)select:(BOOL (NS_NOESCAPE ^)(T item))selectBlock;

/**
 反选操作(与选择操作逻辑相反)

 @param rejectBlock 反选的block，参数为每一项元素，返回值为一个布尔型，为YES时表示返回序列中不包含此元素。
 @return 一个EZSequence实例，元素为反选后剩下的元素。
 */
- (EZSequence<T> *)reject:(BOOL (NS_NOESCAPE ^)(T item))rejectBlock;

/**
 聚合操作。操作流程为：
    1. `startValue`作为起始值，被传入`reduceBlock`的`accumulator`参数，同时，`item`为遍历到的第一个元素
    2. 在`reduceBlock`中，通过`accumulator`和当前的`item`，计算出一个值并返回，作为下一次迭代时传入的`accumulator`
    3. 重复步骤2，直到遍历完成
    4. 返回最后一次遍历执行的`reduceBlock`的返回值

 Note:
    - 如果EZSequence中没有元素，则返回值为`startValue`
    - 如果EZSequence中只有一个元素，则返回值为`startValue`与第一个元素进行操作后的结果
 
 @param startValue 起始值
 @param reduceBlock reduce计算的block，参数为:
    - accumulator: 累计操作后的值
    - item: 当前元素
    返回值为：accumulator和item进行缩减操作后的值，作为下一次的accumulator
 @return 操作完成后的最终结果
 */
- (id)reduceStart:(nullable id)startValue withBlock:(id _Nullable(NS_NOESCAPE ^)(id _Nullable accumulator, T _Nullable item))reduceBlock;

/**
 聚合操作。与‘reduceStart:withBlock:’比，不具有起始值。操作流程为：
     1. 对EZSequence从第二个元素开始遍历。遍历到第二个元素时，将第一个元素传入`reduceBlock`的`accumulator`参数，同时，`item`为遍历到的第二个元素
     2. 在`reduceBlock`中，通过`accumulator`和当前的`item`，计算出一个值并返回，作为下一次迭代时传入的`accumulator`
     3. 重复步骤2，直到遍历完成
     4. 返回最后一次遍历执行的`reduceBlock`的返回值
 
 Note:
     - 如果EZSequence中没有元素，则返回值为`nil`
     - 如果EZSequence中只有一个元素，则返回值为第一个元素

 @param reduceBlock reduce计算的block, 参数为:
    accumulator - 累计操作的值
    item - 当前元素
    返回值为：accumulator和item进行缩减操作后的值，作为下一次的accumulator

 @return 操作完成后的最终结果
 */
- (id)reduce:(id (NS_NOESCAPE ^)(id accumulator, T item))reduceBlock;

/**
 zip配对操作。操作流程为：
    1. `sequences`是一个快速枚举协议的对象，其元素也是实现了快速枚举协议的对象
    2. 对`sequences`的元素同时进行遍历，并把同时遍历一次所得到的全部对象封装为一个EZSequence，作为元素加入到要返回的EZSequence中
    3. 如果任意一个元素被遍历完成，则整个遍历结束，返回最终的EZSequence

 @param sequences 实现了快速枚举协议的序列，元素必须也实现了快速枚举协议
 @return 一个EZSequence实例，元素为zip配对后的EZSequence
 */
+ (EZSequence<EZSequence *> *)zip:(id<NSFastEnumeration>)sequences;

/**
 Groups the array by the result of the block. Returns an empty dictionary if the original array is empty.
 
 @param groupBlock The block applyed to each item of the original array, the return value will be used as the key of the result dictionary.
 @return A dictionary where the keys are the returned values of the block, and the values are arrays of objects in the original array that correspond to the key.
 */
- (NSDictionary<id<NSCopying>, EZSequence<T> *> *)groupBy:(id<NSCopying> (NS_NOESCAPE ^)(T value))groupBlock;

@end

NS_ASSUME_NONNULL_END
