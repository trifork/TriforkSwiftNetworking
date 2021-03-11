import Foundation

/// Stub responses for mocking `URLSession`
public class URLSessionStubResponses {

    /// Creates a stub instance of `HTTPURLResponse` based on the given parameters
    /// - Parameters:
    ///   - url: The url for the request.
    ///   - statusCode: Defaults to `200`
    ///   - headers: HTTP headers.
    public static func response(url: URL, statusCode: Int = 200, headers: [String: String]? = nil) -> HTTPURLResponse? {
        HTTPURLResponse(
            url: url,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: headers
        )
    }
}
