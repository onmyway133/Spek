//
//  TestAppTests.swift
//  TestAppTests
//
//  Created by khoa on 11/01/2020.
//  Copyright © 2020 Khoa Pham. All rights reserved.
//

import XCTest
import Spek

class TestAppTests: XCTestCase {
    func testExample() {
        spec {
            Describe("math") {
                It("should add correctly") {
                    XCTAssertTrue(1 + 1 == 2)
                }
            }
        }
    }
}
