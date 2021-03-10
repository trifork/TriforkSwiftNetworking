import Foundation

@objc public class URLProtocolMock: URLProtocol {
    public static var data = [URL?: Data]()
    public static var responses = [URL?: URLResponse]()
    public static var errors = [URL?: NSError]()

    public class func reset() {
        data.removeAll()
        responses.removeAll()
        errors.removeAll()
    }

    public override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    public override class func canInit(with task: URLSessionTask) -> Bool {
        return true
    }

    public override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    public override func startLoading() {
        if let url = request.url {
            if let data = URLProtocolMock.data[url] {
                self.client?.urlProtocol(self, didLoad: data)
            }

            if let response = URLProtocolMock.responses[url] {
                self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }

            if let error = URLProtocolMock.errors[url] {
                self.client?.urlProtocol(self, didFailWithError: error)
            }
        }

        self.client?.urlProtocolDidFinishLoading(self)
    }

    // This method is required, but we doesn't need to do anything
    public override func stopLoading() {

    }
}
