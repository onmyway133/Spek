//
//  SpekTestCase.swift
//  Spek
//
//  Created by khoa on 11/01/2020.
//

/*

#if canImport(XCTest)

import XCTest

#if canImport(SpekHelper)
import SpekHelper
#else
public typealias SpekHelperTestCase = XCTestCase
#endif

open class SpekTestCase: SpekHelperTestCase {
    open func makeDescribe() -> Describe {
        return Describe("empty")
    }

    #if canImport(SpekHelper)

    override class func spek_testMethodSelectors() -> [SpekSelector] {
        let _ = addInstanceMethod()
        return [
            SpekSelector(selector: Selector("testABC"))
        ]
    }

    private static func addInstanceMethod() -> Selector {
        let block: @convention(block) (SpekTestCase) -> Void = { spec in
           print("hello")
        }

        let implementation = imp_implementationWithBlock(block as Any)
        let selector = NSSelectorFromString("testABC")
        class_addMethod(self, selector, implementation, "v@:")

        return selector
    }

    #endif
}

#endif

*/
