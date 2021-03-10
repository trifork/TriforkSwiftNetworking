import Foundation

public class URLResponseMocks {
    public static func response(statusCode: Int = 200, url: URL, headers: [String: String]? = nil) -> HTTPURLResponse? {
        HTTPURLResponse(
            url: url,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: headers
        )
    }
}
