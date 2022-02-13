import XCTest
@testable import Cjq

final class CjqTests: XCTestCase {
    func testExample() throws {
        let state = jq_init()
        jq_compile(state, "[map(.)[] | select(. % 2 == 0)] | length")
        jq_start(state, jv_parse("[1,2,3,4]"), 0)
        let result = jq_next(state)
        XCTAssertEqual(jv_number_value(result), 2)
    }
}
