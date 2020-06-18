//
//  Endpoint.swift
//  MarvelFlutter
//
//  Created by Pedro Felipe Coloma de Araujo on 18/06/20.
//  Copyright © 2020 Pedro Felipe Coloma de Araujo. All rights reserved.
//

import Foundation

enum APIMethod: String {
    case post = "POST"
    case get = "GET"
}

enum Endpoint {
    case characters
    case comics
    case comicDetailsImage(_ path: Thumbnail)
    
    var method: APIMethod {
        switch self {
        case .characters, .comics, .comicDetailsImage:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .characters:
            return "v1/public/characters"
        case .comics:
            return "v1/public/comics"
        case .comicDetailsImage(let path):
            return "\(path.path + path.extension)"
        }
    }
    
    var url: URL {
        switch self {
        case .comicDetailsImage(let path):
            return URL(string: "https" + path.path.dropFirst(4) + "/standard_amazing." + path.extension)!
        default:
            return URL(string: API.baseUrl + path + API.authData())!
        }
    }
}
