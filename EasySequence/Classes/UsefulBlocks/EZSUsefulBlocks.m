//
//  EZSUsefulBlocks.m
//  EasySequence
//
//  Created by William Zang on 2018/4/20.
//

#import "EZSUsefulBlocks.h"

EZSFliterBlock EZS_isKindOf_(Class klass) {
    return ^BOOL(id instance) {
        return [instance isKindOfClass:klass];
    };
}

EZSFliterBlock EZS_isEqual(id value) {
    return ^BOOL(id instance) {
        return instance == value || [instance isEqual:value];
    };
}

EZSFliterBlock EZS_not(EZSFliterBlock block) {
    return ^BOOL(id instance) {
        return !block(instance);
    };
}

EZSFliterBlock EZS_isExists() {
    return ^BOOL(id _) {
        return !!_;
    };
}

EZSMapBlock EZS_propertyWith(NSString *propertyName) {
    return ^id(id object) {
        return [object valueForKeyPath:propertyName];
    };
}

EZSMapBlock EZS_valueWithKey(NSString *keyName) {
    return ^id(NSDictionary *dictionary) {
        NSCAssert([dictionary isKindOfClass:[NSDictionary class]], @"%@ is not a dictionary", dictionary);
        return dictionary[keyName];
    };
}
