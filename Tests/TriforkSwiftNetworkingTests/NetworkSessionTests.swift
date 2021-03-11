import Foundation
import TSNMockHelpers
import XCTest
@testable import TriforkSwiftNetworking

final class NetworkSessionTests: XCTestCase {

    let session: NetworkSession = URLSession.mockSession
    let baseUrl = "http://example.com"

    func testDataTask() {
        let request = TestRequest(
            baseUrl: baseUrl,
            pathComponents: ["test", "mock"],
            method: .get,
            query: nil,
            body: nil,
            headers: nil,
            cachePolicy: .useProtocolCachePolicy
        )

        let url = URL(string: "\(baseUrl)/test/mock")
        URLSessionStubResults.resultsForUrls[url] = .dataResponse(
            data: "MyData".data(using: .utf8)!,
            response: URLSessionStubResponses.response(url: url!)!
        )

        let expect = XCTestExpectation()
        session.dataTask(with: request) { (data, response, error) in
            XCTAssertEqual("MyData", String(data: data!, encoding: .utf8))
            XCTAssertNil(error)
            XCTAssertEqual(200, (response as? HTTPURLResponse)?.statusCode)
            expect.fulfill()
        }.resume()
        wait(for: [expect], timeout: 1.0)
    }
}
