import Foundation
import TriforkSwiftNetworking

struct TestRequst: HTTPRequest {
    typealias ResponseType = TestResonse

    var baseUrl: String
    var pathComponents: [String]
    var method: HTTPMethod
    var query: [String: String]?
    var body: Data?
    var headers: [String: String]?
    var cachePolicy: URLRequest.CachePolicy
}

struct TestResonse: Response {
    typealias OutputType = Example

    init(input: Data, response: HTTPURLResponse?) throws {

    }
}

struct Example: Decodable {
    let title: String
    let text: String
}
