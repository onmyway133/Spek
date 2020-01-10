import XCTest
@testable import Spek

final class SpekTests: XCTestCase {
    func testExample() {
        spec {
            Describe("abc") {
                Describe("def") {
                    BeforeEach {

                    }

                    AfterEach {

                    }

                    It("should work") {
                        XCTAssertTrue(true)
                    }

                    It("should not work") {
                        XCTAssertTrue(false)
                    }
                }
            }
        }
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
