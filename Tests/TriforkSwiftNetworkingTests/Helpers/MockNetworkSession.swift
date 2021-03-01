import Foundation
import TriforkSwiftNetworking
import Combine

final class MockNetworkSession: NetworkSession {
    var request: URLRequest!

    func dataTask(with request: URLRequest) -> URLSessionDataTask {
        self.request = request

        return URLSession.shared.dataTask(with: request)
    }

    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.request = request

        return URLSession.shared.dataTask(with: request)
    }

    @available(iOS 13.0, *)
    func dataTaskPublisher(for request: URLRequest) -> URLSession.DataTaskPublisher {
        self.request = request

        return URLSession.shared.dataTaskPublisher(for: request)
    }
}
