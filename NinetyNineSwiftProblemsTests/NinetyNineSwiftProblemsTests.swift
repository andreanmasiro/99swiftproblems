import XCTest

class Test1: XCTestCase {
    func test1() {
        XCTAssertEqual(List(1, 1, 2, 3, 5, 8).last, 8)
    }
}
