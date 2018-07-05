//
//  beReleasedCorrectly.swift
//  EasyReact
//
//  Created by nero on 2017/8/3.
//  Copyright (c) 2018 Beijing Sankuai Online Technology Co.,Ltd (Meituan)
//

import Foundation
import Nimble
import Quick

@objc public class CheckReleaseTool: NSObject {
    
    @objc var checkTable = NSHashTable<NSObject>.weakObjects()
    
    @objc public func checkObj(_ obj: NSObject?) {
        checkTable.add(obj)
    }
    
}

@objc public class CheckReleaseToolBlockContainer: NSObject {
    @objc public var checkReleaseTool: ((CheckReleaseTool) -> Void)?
}


public func beReleasedCorrectly() -> Predicate<CheckReleaseToolBlockContainer> {
    return Predicate.define("") { actualExpress, msg in
        
        let actual = try actualExpress.evaluate()
        let checkTool = CheckReleaseTool()
        
        guard let container = actual, let closure = container.checkReleaseTool else {
            return PredicateResult(bool:false, message:msg.appended(message: "the expected block is not given"))
        }
        
        autoreleasepool {
            autoreleasepool {
                closure(checkTool)
            }
        }
        return PredicateResult(bool: checkTool.checkTable.allObjects.count == 0 ,
                               message: .fail("expected: all check object to be released, got: \(checkTool.checkTable.allObjects) still exists"))
    }
}

@objc extension NMBObjCMatcher {
    public class func beReleasedCorrectlyMatcher() -> NMBObjCMatcher {
        return NMBObjCMatcher(canMatchNil: false) { (actualExpression, failureMessage) -> Bool in
            let expr = actualExpression.cast {
                $0 as? CheckReleaseToolBlockContainer
            }
            return try! beReleasedCorrectly().matches(expr , failureMessage: failureMessage)
        }
    }
}


