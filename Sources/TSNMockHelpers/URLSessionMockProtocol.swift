import Foundation

/// Internal protocol class for mocking `URLSession`
@objc class URLSessionMockProtocol: URLProtocol {

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canInit(with task: URLSessionTask) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let results = URLSessionStubResults.resultsForUrls[request.url] {
            if let data = results.data {
                self.client?.urlProtocol(self, didLoad: data)
            }

            if let response = results.response {
                self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }

            if let error = results.error {
                self.client?.urlProtocol(self, didFailWithError: error)
            }
        }

        self.client?.urlProtocolDidFinishLoading(self)
    }

    // This method is required, but we doesn't need to do anything
    override func stopLoading() {

    }
}
