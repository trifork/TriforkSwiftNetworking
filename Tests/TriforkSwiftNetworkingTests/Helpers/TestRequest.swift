import Foundation
import TriforkSwiftNetworking

struct TestRequest: HTTPRequest {
    typealias ResponseType = TestResponse

    var baseUrl: String
    var pathComponents: [String]
    var method: HTTPMethod
    var query: [String: String]?
    var body: Data?
    var headers: [String: String]?
    var cachePolicy: URLRequest.CachePolicy
}

struct TestResponse: Response {
    typealias OutputType = Example

    init(input: Data, response: HTTPURLResponse?) throws {

    }
}

struct Example: Decodable {
    let title: String
    let text: String
}
