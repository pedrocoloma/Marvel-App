//
//  ComicsModel.swift
//  MarvelFlutter
//
//  Created by Pedro Felipe Coloma de Araujo on 18/03/20.
//  Copyright © 2020 Pedro Felipe Coloma de Araujo. All rights reserved.
//

import Foundation

struct Thumbnail: Codable {
    var path: String
    var `extension`: String
}

struct Comic: Codable {
    var id: Int
    var title: String
    var description: String?
    var thumbnail: Thumbnail
}

struct ComicData: Codable {
    var offset: Int
    var results: [Comic]
}

struct ComicsModel: Codable {
    var code: Int?
    var copyright: String?
    var data: ComicData
}
