//
//  MarvelError.swift
//  MarvelFlutter
//
//  Created by Pedro Felipe Coloma de Araujo on 18/06/20.
//  Copyright © 2020 Pedro Felipe Coloma de Araujo. All rights reserved.
//

import Foundation

enum MarvelError: Error {
    case parse
    case network
    case unknown
    
    var localizedDescription: String {
        switch self {
        case .parse:
            return "Parsing error"
        case .network:
           return "Network error"
        case .unknown:
            return "Unknown error"
        }
    }
}
