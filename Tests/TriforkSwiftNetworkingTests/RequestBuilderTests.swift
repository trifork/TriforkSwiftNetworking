import XCTest
@testable import TriforkSwiftNetworking

final class RequestBuilderTests: XCTestCase {
    let baseUrl = "http://example.com"

    func testRequestBuilderWithQueryAndNoPathComponent() {
        let request = TestRequest(baseUrl: baseUrl,
                                 pathComponents: [],
                                 method: .get,
                                 query: ["bar": "baz"],
                                 cachePolicy: .useProtocolCachePolicy)

        verifyRequest(request)
    }

    func testRequestBuilderWithQueryAndPathComponent() {
        let request = TestRequest(baseUrl: baseUrl,
                                 pathComponents: ["foo"],
                                 method: .get,
                                 query: ["bar": "baz"],
                                 cachePolicy: .reloadRevalidatingCacheData)

        verifyRequest(request)
    }

    func testRequestBuilderWithBody() throws {
        let jsonEncoder = JSONEncoder()
        let data = try jsonEncoder.encode(UUID().uuidString)

        let request = TestRequest(baseUrl: baseUrl,
                                 pathComponents: ["foo"],
                                 method: .post,
                                 query: ["bar": "baz"],
                                 body: data,
                                 cachePolicy: .reloadIgnoringCacheData)

        verifyRequest(request)
    }

    func testRequestBuilderWithHeaders() throws {
        let jsonEncoder = JSONEncoder()
        let data = try jsonEncoder.encode(UUID().uuidString)

        let request = TestRequest(baseUrl: baseUrl,
                                 pathComponents: ["foo"],
                                 method: .post,
                                 query: ["bar": "baz"],
                                 body: data,
                                 headers: ["foo": "test"],
                                 cachePolicy: .returnCacheDataElseLoad)

        verifyRequest(request)
    }

    func verifyRequest(_ request: TestRequest) {
        var requests = [URLRequest]()
        let mockSession = MockNetworkSession()

        _ = mockSession.dataTask(with: request)
        XCTAssertNotNil(mockSession.request)
        requests.append(mockSession.request)

        if #available(iOS 13.0, *) {
            _ = mockSession.dataTaskPublisher(for: request)
            XCTAssertNotNil(mockSession.request)
            requests.append(mockSession.request)
        }

        for urlRequest in requests {
            let path = ([baseUrl] + request.pathComponents).joined(separator: "/")
            let query = request.query?.map { $0 + "=" + $1 }.joined(separator: "&")

            let endUrl = [path, query].compactMap { $0 }.joined(separator: "?")

            XCTAssertEqual(endUrl, urlRequest.url?.absoluteString)
            XCTAssertEqual(request.method.rawValue.uppercased(), urlRequest.httpMethod)
            XCTAssertEqual(request.body, urlRequest.httpBody)
            XCTAssertEqual(request.headers ?? [:], urlRequest.allHTTPHeaderFields)
            XCTAssertEqual(request.cachePolicy, urlRequest.cachePolicy)
        }
    }
}
