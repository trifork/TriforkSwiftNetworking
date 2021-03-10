import Foundation

public class URLResponseMocks {
    public static func response(url: URL, statusCode: Int = 200, headers: [String: String]? = nil) -> HTTPURLResponse? {
        HTTPURLResponse(
            url: url,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: headers
        )
    }
}
