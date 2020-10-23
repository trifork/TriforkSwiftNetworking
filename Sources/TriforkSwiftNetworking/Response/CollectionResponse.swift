//
//  CollectionResponse.swift
//  
//  Created by Kim de Vos on 21/10/2020.
//  Copyright © 2020 Trifork Public A/S. All rights reserved.
//

import Foundation

/// Simple response that contains a collection of the `OutputType`.
public protocol CollectionResponse: Response {
    var data: [OutputType] { get }
}
