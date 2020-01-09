import XCTest

import SpekTests

var tests = [XCTestCaseEntry]()
tests += SpekTests.allTests()
XCTMain(tests)
