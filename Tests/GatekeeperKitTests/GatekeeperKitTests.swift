import XCTest
@testable import GatekeeperKit

final class GatekeeperKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(GatekeeperKit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
