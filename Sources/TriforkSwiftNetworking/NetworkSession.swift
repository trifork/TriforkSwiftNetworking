//
//  NetworkSession.swift
//
//  Created by Kim de Vos on 21/10/2020.
//  Copyright © 2020 Trifork Public A/S. All rights reserved.
//

import Foundation
#if canImport(Combine)
import Combine
#endif

public protocol NetworkSession {
    /// Creates a task that retrieves the contents of a URL based on the specified URL request object.
    ///
    /// - Parameter request: A URL request object that provides request-specific information such as the URL, cache policy, request type, and body data or body stream.
    /// - Returns: The new session data task.
    func dataTask(with request: URLRequest) -> URLSessionDataTask

    #if canImport(Combine)
    /// Returns a publisher that wraps a URL session data task for a given URL request.
    ///
    /// The publisher publishes data when the task completes, or terminates if the task fails with an error.
    /// - Parameter request: The URL request for which to create a data task.
    /// - Returns: A publisher that wraps a data task for the URL request.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func dataTaskPublisher(for request: URLRequest) -> URLSession.DataTaskPublisher
    #endif
}

// Helper mehtods
public extension NetworkSession {
    /// Creates a task that retrieves the contents of a URL based on the specified URL request object.
    ///
    /// - Parameter request: A HTTP request object that provides request-specific information such as the URL, cache policy, request type, and body data or body stream.
    /// - Returns: The new session data task.
    func dataTask<Request: HTTPRequest>(with request: Request) -> URLSessionDataTask {
        let urlRequest = createRequest(with: request)

        return dataTask(with: urlRequest)
    }

    #if canImport(Combine)
    /// Returns a publisher that wraps a URL session data task for a given URL request.
    ///
    /// The publisher publishes data when the task completes, or terminates if the task fails with an error.
    /// - Parameter request: The HTTP request for which to create a data task.
    /// - Returns: A publisher that wraps a data task for the URL request.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func dataTaskPublisher<Request: HTTPRequest>(for request: Request) -> AnyPublisher<Request.ResponseType, Error> {
        let urlRequest = createRequest(with: request)

        return dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                try Request.ResponseType.init(input: data, response: response as? HTTPURLResponse)
        }
        .mapError { $0 }
        .eraseToAnyPublisher()
    }
    #endif
}

private extension NetworkSession {
    private func createRequest<Request: HTTPRequest>(with request: Request) -> URLRequest {
        var url = request.url

        request.query?.forEach { key, value in
            url = url.appendingQueryComponent(key, value: value)
        }

        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = request.method.rawValue.uppercased()
        urlRequest.httpBody = request.body

        request.headers?.forEach({ key, value in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        })

        if TriforkSwiftNetworkingConfig.isDebugPrintingEnabled {
            log(for: urlRequest)
        }

        return urlRequest
    }

    private func log(for urlRequest: URLRequest) {
        let bodyString: String
        let noBodyDataString = "<NO BODY DATA>"
        if let data = urlRequest.httpBody {
            bodyString = String(data: data, encoding: .utf8) ?? noBodyDataString
        } else {
            bodyString = noBodyDataString
        }
        let logMessage =  """
Created \(urlRequest.httpMethod ?? "<UNKNOWN>") request for:
URL: \(urlRequest.url?.absoluteString ?? "<UNKNOWN>")
HEADERS ⬇️:
\(urlRequest.allHTTPHeaderFields?.description ?? "<NO HEADERS>")
BODY ⬇️:
\(bodyString)
"""
        Logger.log(logMessage)
    }
}
