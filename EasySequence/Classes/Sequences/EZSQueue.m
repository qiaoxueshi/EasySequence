//
//  EZSQueue.m
//  EasySequence
//
//  Created by nero on 2018/5/2.
//

#import "EZSQueue.h"
#import "EZSArray.h"
#import "EZSequence+Operations.h"
#import "EZSUsefulBlocks.h"

@implementation EZSQueue {
    EZSArray *_insideArray;
}
- (instancetype)init {
    if (self = [super init]) {
        _insideArray = [EZSArray new];
    }
    return self;
}

- (BOOL)isEmpty {
    return _insideArray.count == 0;
}

- (NSUInteger)count {
    return _insideArray.count;
}

- (void)enqueue:(id)item {
    [_insideArray addObject:item ?: NSNull.null];
}

- (id)dequeue {
    @synchronized(_insideArray) {
        id front = EZS_Sequence(_insideArray).firstObject;
        if (front) {
            [_insideArray removeObjectAtIndex:0];
            front = [front isEqual:NSNull.null] ? nil : front;
        }
        return front;
    }
}

- (id)front {
    id front = EZS_Sequence(_insideArray).firstObject;
    front = [front isEqual:NSNull.null] ? nil : front;
    return front;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EZSQueue *newQueue = [[self class] allocWithZone:zone];
    newQueue->_insideArray = [_insideArray copy];
    return newQueue;
}

- (BOOL)isEqual:(EZSQueue *)object {
    if ([object isKindOfClass:[self class]]) {
        return [_insideArray isEqual:object->_insideArray];
    }
    return NO;
}

- (BOOL)contains:(id)item {
    return [EZS_Sequence(_insideArray) any:EZS_isEqual(item)];
}

+ (instancetype)transferFromSequence:(EZSequence *)sequence {
    EZSQueue *queue = [[EZSQueue alloc] init];
    [sequence forEach:^(id  _Nonnull item) {
        [queue enqueue:item];
    }];
    return queue;
}

- (NSString *)description {
    return [NSString stringWithFormat:@" %@: %@", NSStringFromClass([self class]), EZS_Sequence(_insideArray)];
}

@end
