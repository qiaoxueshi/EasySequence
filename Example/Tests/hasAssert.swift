//
//  hasParameterAssert.swift
//  EasyReact_Tests
//
//  Created by nero on 2017/8/8.
//  Copyright (c) 2018 Beijing Sankuai Online Technology Co.,Ltd (Meituan)
//

import Foundation
import Nimble
import XCTest
import Quick


@objc public class AssertBlockContainer: NSObject {
    @objc public var action: (() -> Void)?
}

public func assertPredicate(_ isParamAssert: Bool) -> Predicate<AssertBlockContainer> {
    return Predicate.define("") { (actualExpress, msg) -> PredicateResult in
        #if DEBUG
            let actual = try actualExpress.evaluate()
            guard let container = actual, let closure = container.action else {
                return PredicateResult(bool:false, message:msg.appended(message: "the expected block is not given"))
            }
            
            let assertHandler = AssertionHandler()
            Thread.current.threadDictionary.setValue(assertHandler, forKey: NSAssertionHandlerKey)
            closure()
            Thread.current.threadDictionary.removeObject(forKey: NSAssertionHandlerKey)
            
            if isParamAssert {
                return PredicateResult(bool: assertHandler.parameterAssertExecption != nil,
                                       message:.fail("the target does not contain NSParameterAssert or NSCParameterAssert."));
            } else {
                return  PredicateResult(bool: assertHandler.assertExecption != nil,
                                        message:.fail("the target does not contain NSAssert or NSCAssert."));
            }
        #else
            return PredicateResult(bool: true, message: msg)
        #endif
    }
}

@objc extension NMBObjCMatcher {
    
    public class func hasParameterAssertMatcher() -> NMBObjCMatcher {
        return NMBObjCMatcher(canMatchNil: false) {  (actualExpression, failureMessage) -> Bool in
            let expr = actualExpression.cast {
                $0 as? AssertBlockContainer
            }
            return try! assertPredicate(true).matches(expr, failureMessage:  failureMessage)
        }
    }
    
    public class func hasAssertMatcher() -> NMBObjCMatcher {
        return NMBObjCMatcher(canMatchNil: false) {  (actualExpression, failureMessage) -> Bool in
            let expr = actualExpression.cast {
                $0 as? AssertBlockContainer
            }
            return try! assertPredicate(false).matches(expr, failureMessage:  failureMessage)
        }
    }
    
}
