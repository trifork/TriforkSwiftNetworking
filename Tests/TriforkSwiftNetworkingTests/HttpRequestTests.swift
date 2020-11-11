import XCTest
@testable import TriforkSwiftNetworking

final class HttpRequestTests: XCTestCase {
    let baseUrl = "http://example.com"

    func testUrlExtensionWithNoPathComponents() {
        let request = TestRequst(baseUrl: baseUrl, pathComponents: [], method: .get)

        XCTAssertEqual(baseUrl, request.url.absoluteString)
        XCTAssertEqual(.get, request.method)
    }

    func testUrlExtensionWithPathComponents() {
        let request = TestRequst(baseUrl: baseUrl, pathComponents: ["foo", "bar"], method: .post)

        XCTAssertEqual(baseUrl + "/foo/bar", request.url.absoluteString)
        XCTAssertEqual(.post, request.method)
    }

    func testUrlExtensionWithPathComponentsAndSlashAfterBaseUrl() {
        let request = TestRequst(baseUrl: baseUrl + "/", pathComponents: ["foo", "bar"], method: .put)

        XCTAssertEqual(baseUrl + "/foo/bar", request.url.absoluteString)
        XCTAssertEqual(.put, request.method)
    }
}
