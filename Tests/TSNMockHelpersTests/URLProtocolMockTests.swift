import Foundation
import XCTest
@testable import TSNMockHelpers

final class HttpRequestTests: XCTestCase {
    let baseUrl = "http://example.com"
    let mockSession: URLSession = .mockSession

    func testDataResponse() {
        URLProtocolMock.reset()
        let url = URL(string: "mock://test.com/data")
        URLProtocolMock.data[url] = "MyData".data(using: .utf8)
        URLProtocolMock.responses[url] = URLResponseMocks.response(url: url!)

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
        URLProtocolMock.reset()
        let url = URL(string: "mock://test.com/error")

        URLProtocolMock.errors[url] = NSError(domain: "TestDomain", code: 1337, userInfo: nil)

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
