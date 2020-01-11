//
//  GenerateTestCaseTests.swift
//  SpekTests
//
//  Created by khoa on 11/01/2020.
//

import XCTest
import Spek

class GenerateTestCaseTests: SpekTestCase {
    override func makeDescribe() -> Describe {
        Describe("math") {
            It("should work") {
                XCTAssertTrue(1 + 1 == 2)
            }
        }
    }
}
