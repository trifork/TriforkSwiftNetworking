import Foundation

/// Contains the stub results for URLs
public struct URLSessionStubResults {
    /// Contains stub results for specific URLs, which will be used when mocking `URLSession` via `URLSessionMockProtocol`
    public static var resultsForUrls: [URL?: URLSessionStubResult] = [:]

    /// Resets the stub storage
    public static func reset() {
        resultsForUrls.removeAll()
    }
}

/// Stub results for `URLSession` mocking via `URLSessionMockProtocol`
public struct URLSessionStubResult {
    public let response: URLResponse?
    public let error: NSError?
    public let data: Data?

    /// Private init to make sure that we don't create unrealistic setups
    private init(response: URLResponse?, error: NSError?, data: Data?) {
        self.response = response
        self.error = error
        self.data = data
    }

    /// Stub for successful networkRequest with response and data
    public static func dataResponse(data: Data, response: URLResponse) -> URLSessionStubResult {
        URLSessionStubResult(
            response: response,
            error: nil,
            data: data
        )
    }

    /// Creates stub for failing network request, e.g. network problems.
    public static func error(error: NSError) -> URLSessionStubResult {
        URLSessionStubResult(
            response: nil,
            error: error,
            data: nil
        )
    }
}
