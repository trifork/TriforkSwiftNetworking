import XCTest
@testable import TriforkSwiftNetworking

final class HttpRequestTests: XCTestCase {
    let baseUrl = "http://example.com"

    func testUrlExtensionWithNoPathComponents() {
        let request = TestRequst(baseUrl: baseUrl,
                                 pathComponents: [],
                                 method: .get,
                                 cachePolicy: .reloadIgnoringCacheData)

        XCTAssertEqual(baseUrl, request.url.absoluteString)
        XCTAssertEqual(.get, request.method)
    }

    func testUrlExtensionWithPathComponents() {
        let request = TestRequst(baseUrl: baseUrl,
                                 pathComponents: ["foo", "bar"],
                                 method: .post,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)

        XCTAssertEqual(baseUrl + "/foo/bar", request.url.absoluteString)
        XCTAssertEqual(.post, request.method)
    }

    func testUrlExtensionWithPathComponentsAndSlashAfterBaseUrl() {
        let request = TestRequst(baseUrl: baseUrl + "/",
                                 pathComponents: ["foo", "bar"],
                                 method: .put,
                                 cachePolicy: .reloadRevalidatingCacheData)

        XCTAssertEqual(baseUrl + "/foo/bar", request.url.absoluteString)
        XCTAssertEqual(.put, request.method)
    }
}
