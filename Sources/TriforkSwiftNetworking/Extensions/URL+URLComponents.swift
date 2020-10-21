//
//  NetworkSession.swift
//
//  Created by Kim de Vos on 21/10/2020.
//  Copyright © 2020 Trifork Public A/S. All rights reserved.
//

import Foundation

extension URL {
    func appendingQueryComponent(_ name: String, value: String?) -> URL {
        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }

        let queryItems = urlComponents.queryItems ?? []
        let queryItem = URLQueryItem(name: name, value: value)

        urlComponents.queryItems = queryItems + [queryItem]

        return urlComponents.url ?? absoluteURL
    }
}
