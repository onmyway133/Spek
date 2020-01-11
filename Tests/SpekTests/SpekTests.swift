import XCTest
@testable import Spek

final class SpekTests: XCTestCase {
    func testExample() {
        var left = 0
        var right = 0
        spec {
            Describe("math") {
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

    static var allTests = [
        ("testExample", testExample),
    ]
}
