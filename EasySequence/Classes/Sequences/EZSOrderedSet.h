//
//  EZSOrderedSet.h
//  EasySequence
//
//  Created by William Zang on 2018/4/20.
//

#import <Foundation/Foundation.h>
#import <EasySequence/EZSTransfer.h>

NS_ASSUME_NONNULL_BEGIN

@interface EZSOrderedSet<__covariant T> : NSObject <NSFastEnumeration, NSCopying, EZSTransfer>

// The number of objects in the orderset.
@property (readonly) NSUInteger count;

- (instancetype)initWithNSArray:(NSArray<T> *)array;
- (instancetype)initWithNSOrderedSet:(NSOrderedSet<T> *)set NS_DESIGNATED_INITIALIZER;

// Returns the object located at the specified index.
- (T)objectAtIndex:(NSUInteger)index;

/**
 Inserts a given object at the end of the orderset.

 @param anObject    The object to add to the end of the orderset’s content. This value must not be `nil`
 */
- (void)addObject:(T)anObject;

/**
 Inserts a given object into the orderset’s contents at a given index.

 @param anObject    The object to add to the orderset’s content. This value must not be `nil`
 @param index       The index in the orderset at which to insert `anObject`. This value must not be greater than the count of elements in the orderset
 */
- (void)insertObject:(T)anObject atIndex:(NSUInteger)index;

// Removes the last object of the orderset. 
- (void)removeLastObject;

// Removes the first object of the orderset.
- (void)removeFirstObject;

/**
 Removes the object at the specified index.

 @param index    The index from which to remove the object in the orderset. The value must not exceed the bounds of the orderset
 */
- (void)removeObjectAtIndex:(NSUInteger)index;

/**
 Removes the specified object.

 @param anObject The object to remove from the orderset. This value must not be 'nil'
 */
- (void)removeObject:(T)anObject;

// Removes all the objects of the orderset.
- (void)removeAllObjects;

/**
 Replaces the object at `index` with `anObject`.

 @param index       The index of the object to be replaced. This value must not exceed the bounds of the orderset.
 @param anObject    The object with which to replace the object at the index in the orderset. This value must not be nil.
 */
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(T)anObject;

- (NSArray<T> *)allObjects;

/**
 Replaces the object at the index with the new object, possibly adding the object.

 @param obj    The object with which to replace the object at the index in the orderset. This value must not be `nil`
 @param idx    The index of the object to be replaced. This value must not exceed the bounds of the orderset
 */
- (void)setObject:(T)obj atIndexedSubscript:(NSUInteger)idx;

/**
 Returns the object at the specified index.

 @param index    An index within the bounds of the orderset
 @return         The object located at `index`
 */
- (T)objectAtIndexedSubscript:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
