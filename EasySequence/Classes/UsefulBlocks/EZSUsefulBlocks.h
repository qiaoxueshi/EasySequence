//
//  EZSUsefulBlocks.h
//  EasySequence
//
//  Created by William Zang on 2018/4/20.
//

#import <Foundation/Foundation.h>
#import <EasySequence/EZSBlockDefines.h>

/**
 返回一个 直接返回参数的mapBlock

 @return MapBlock
 */
EZSMapBlock EZS_ID(void);

/**
 通过isKindOf判断，返回一个`EZSFliterBlock`。

 @param klass 需要判断类型的Class
 @return 一个EZSFliterBlock
 */
EZSFliterBlock EZS_isKindOf_(Class klass);
#define EZS_isKindOf(__klass__)     EZS_isKindOf_([__klass__ class])

/**
 通过isEqual判断，返回一个`EZSFliterBlock`。
 
 @param value 需要判断是否相等的对象
 @return 一个EZSFliterBlock
 */
EZSFliterBlock EZS_isEqual(id value);

/**
 返回一个`EZSFliterBlock`，判断元素否存在。
 
 @return 一个EZSFliterBlock
 */
EZSFliterBlock EZS_isExists(void);

/**
 返回一个与入参`EZSFliterBlock`相反情况的`EZSFliterBlock`。
 
 @param block `EZSFliterBlock`类型的block
 @return 一个EZSFliterBlock
 */
EZSFliterBlock EZS_not(EZSFliterBlock block);

/**
 得到一个KeyPath字符串(此写法带语法检查以保证keyPath拼写正确)

 @param OBJ Class
 @param PATH keyPath
 @return 返回`PATH`字符串
 */
#define EZS_KeyPath(OBJ, PATH)  (((void)(NO && ((void)[OBJ new].PATH, NO)), @# PATH))

/**
 将一个`EZSMapBlock`中的入参映射为原入参对象的keyPath对象的`EZSMapBlock`.

 @param propertyName KeyPath名称
 @return 一个EZSMapBlock
 */
EZSMapBlock EZS_propertyWith(NSString *propertyName);

/**
 返回一个`EZSMapBlock`。如果一个`EZSMapBlock`中的入参是NSDictionary类型，则将dictionary映射为objectForKey:对象。

 @param keyName 字典的key
 @return 一个的EZSMapBlock
 */
EZSMapBlock EZS_valueWithKey(NSString *keyName);

/**
 遍历每一个元素，并执行元素的`selector`。

 @param selector 要对元素执行的selector
 @return 一个EZSApplyBlock，该block没有返回值
 */
EZSApplyBlock EZS_performSelector(SEL selector);

/**
 遍历每一个元素，并执行元素的`selector`。
 
 @param selector 要对元素执行的selector
 @param param1 第一个参数
 @return 一个EZSApplyBlock，该block没有返回值
 */
EZSApplyBlock EZS_performSelector1(SEL selector, id param1);

/**
 遍历每一个元素，并执行元素的`selector`。
 
 @param selector 要对元素执行的selector
 @param param1 第一个参数
 @param param2 第二个参数
 @return 一个EZSApplyBlock，该block没有返回值
 */
EZSApplyBlock EZS_performSelector2(SEL selector, id param1, id param2);

/**
 将一个`EZSMapBlock`中的入参映射为 元素执行selector之后的结果。

 @param selector 要对元素执行的selector
 @return 一个EZSMapBlock
 */
EZSMapBlock EZS_mapWithSelector(SEL selector);

/**
 将一个`EZSMapBlock`中的入参映射为 元素执行selector之后的结果。
 
 @param selector 要对元素执行的selector
 @param param1 第一个参数
 @return 一个EZSMapBlock
 */
EZSMapBlock EZS_mapWithSelector1(SEL selector, id param1);

/**
 将一个`EZSMapBlock`中的入参映射为 元素执行selector之后的结果。
 
 @param selector 要对元素执行的selector
 @param param1 第一个参数
 @param param2 第二个参数
 @return 一个EZSMapBlock
 */
EZSMapBlock EZS_mapWithSelector2(SEL selector, id param1, id param2);

/**
 判断两个元素实例是否相同

 @param left 需要被判断的实例
 @param right 需要被判断的实例
 @return 实例是否相等
 */
FOUNDATION_EXTERN BOOL EZS_instanceEqual(id left, id right);
