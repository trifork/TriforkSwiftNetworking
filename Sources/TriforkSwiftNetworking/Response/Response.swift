//
//  Response.swift
//  
//  Created by Kim de Vos on 21/10/2020.
//  Copyright © 2020 Trifork Public A/S. All rights reserved.
//

import Foundation

public protocol Response {
    associatedtype OutputType
    init(input: Data, response: HTTPURLResponse?) throws
}

