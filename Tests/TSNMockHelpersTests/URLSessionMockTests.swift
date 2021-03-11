import Foundation
import XCTest
@testable import TSNMockHelpers

final class URLSessionMockTests: XCTestCase {
    let mockSession: URLSession = .mockSession

    func testDataResponse() {
        URLSessionStubResults.reset()
        let url = URL(string: "mock://test.com/data")
        URLSessionStubResults.resultsForUrls[url] = .dataResponse(
            data: "MyData".data(using: .utf8)!,
            response: URLSessionStubResponses.response(url: url!)!
        )

        let expect = XCTestExpectation()
        mockSession.dataTask(with: url!) { (data, response, error) in
            XCTAssertNil(error)
            XCTAssertEqual(200, (response as? HTTPURLResponse)?.statusCode)
            XCTAssertEqual("MyData", String(data: data!, encoding: .utf8))
            expect.fulfill()
        }.resume()
        wait(for: [expect], timeout: 1.0)
    }

    func testError() {
        URLSessionStubResults.reset()
        let url = URL(string: "mock://test.com/error")

        URLSessionStubResults.resultsForUrls[url] = .error(
            error: NSError(domain: "TestDomain", code: 1337, userInfo: nil)
        )

        let expect = XCTestExpectation()
        mockSession.dataTask(with: url!) { (data, response, error) in
            XCTAssertEqual((error! as NSError).code, 1337)
            XCTAssertNil(response)
            XCTAssertNil(data)
            expect.fulfill()
        }.resume()
        wait(for: [expect], timeout: 1.0)
    }
}

private enum TestError : Error {
    case fail
}
