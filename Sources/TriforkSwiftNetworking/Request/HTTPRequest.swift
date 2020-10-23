//
//  HTTPRequest.swift
//  
//  Created by Kim de Vos on 21/10/2020.
//  Copyright © 2020 Trifork Public A/S. All rights reserved.
//

import Foundation

public protocol HTTPRequest {
    associatedtype ResponseType: Response

    /// The URL for the request.
    var url: String { get }

    /// The HTTP request method. Default is `GET`
    var method: HTTPMethod { get }

    /// An dictionary of query items for the URL.
    var query: [String: String]? { get }

    /// The data sent as the message body of a request, such as for an HTTP POST request. 
    var body: Data? { get }

    /// Adds values to the header fields.
    var headers: [String: String]? { get }
}

public extension HTTPRequest {
    var method: HTTPMethod { .get }
    var query: [String: String]? { nil }
    var body: Data? { nil }
    var headers: [String: String]? { nil }
}

public enum HTTPMethod: String {
    case get
    case post
    case put
    case patch
    case delete
}
