//
//  EZSUsefulBlocks.m
//  EasySequence
//
//  Created by William Zang on 2018/4/20.
//

#import "EZSUsefulBlocks.h"

EZSMapBlock EZS_ID(void) {
    return ^id(id _) {
        return _;
    };
}

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

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

EZSApplyBlock EZS_performSelector(SEL selector) {
    return ^(id object) {
        [object performSelector:selector];
    };
}

EZSApplyBlock EZS_performSelector1(SEL selector, id param1) {
    return ^(id object) {
        [object performSelector:selector withObject:param1];
    };
}

EZSApplyBlock EZS_performSelector2(SEL selector, id param1, id param2) {
    return ^(id object) {
        [object performSelector:selector withObject:param1 withObject:param2];
    };
}

EZSMapBlock EZS_mapWithSelector(SEL selector) {
    return ^id(id object) {
        return [object performSelector:selector];
    };
}

EZSMapBlock EZS_mapWithSelector1(SEL selector, id param1) {
    return ^id(id object) {
        return [object performSelector:selector withObject:param1];
    };
}

EZSMapBlock EZS_mapWithSelector2(SEL selector, id param1, id param2) {
    return ^id(id object) {
        return [object performSelector:selector withObject:param1 withObject:param2];
    };
}

#pragma clang diagnostic pop
