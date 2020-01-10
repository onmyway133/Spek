import XCTest
@testable import Spek

final class SpekTests: XCTestCase {
    func testExample() {
        var left = 1
        var right = 1
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
