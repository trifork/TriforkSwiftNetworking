//
//  HTTPRequest.swift
//  
//  Created by Kim de Vos on 21/10/2020.
//  Copyright © 2020 Trifork Public A/S. All rights reserved.
//

import Foundation

public protocol HTTPRequest {
    associatedtype ResponseType: Response

    var url: String { get }
    var method: HTTPMethod { get }
    var query: [String: String]? { get }
    var body: Data? { get }
    var headers: [String: String]? { get }
    var pathComponents: [String] { get }
}

public enum HTTPMethod: String {
    case get
    case post
    case put
    case patch
    case delete
}
