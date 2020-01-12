//
//  GenerateTestCaseTests.swift
//  SpekTests
//
//  Created by khoa on 11/01/2020.
//

import XCTest
import Spek

class GenerateTestCaseTests: SpekTestCase {
    override class func makeDescribe() -> Describe {
        var left = 0
        var right = 0
        return Describe("math") {
            BeforeEach {
                left = 2
            }

            Describe("basic") {
                BeforeEach {
                    right = 3
                }

                AfterEach {

                }

                Sub {
                    let another = 4
                    return Describe("3 operands") {
                        It("adds with another") {
                            XCTAssertEqual(left + right + another, 9)
                        }
                    }
                }

                It("adds correctly") {
                    XCTAssertEqual(left + right, 5)
                }

                It("multiplies correctly") {
                    XCTAssertEqual(left * right, 6)
                }
            }
        }
    }
}
