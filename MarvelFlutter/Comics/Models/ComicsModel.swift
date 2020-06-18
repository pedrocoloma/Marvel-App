//
//  ComicsModel.swift
//  MarvelFlutter
//
//  Created by Pedro Felipe Coloma de Araujo on 18/03/20.
//  Copyright © 2020 Pedro Felipe Coloma de Araujo. All rights reserved.
//

import Foundation

struct Thumbnail: Codable {
    let path: String
    let `extension`: String
}

struct Comic: Codable {
    let id: Int
    let title: String
    var description: String?
    let thumbnail: Thumbnail
}

struct ComicData: Codable {
    let offset: Int
    let results: [Comic]
}

struct ComicsModel: Codable {
    var code: Int?
    var copyright: String?
    let data: ComicData
}
