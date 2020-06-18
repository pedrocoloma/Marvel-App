//
//  CharactersModel.swift
//  MarvelFlutter
//
//  Created by Pedro Felipe Coloma de Araujo on 29/03/20.
//  Copyright © 2020 Pedro Felipe Coloma de Araujo. All rights reserved.
//

import Foundation

struct CharactersComicsData: Codable {
    var items: [CharactersComic]?
}

struct CharactersComic: Codable {
    let resourceURI: String
    let name: String
}

struct Character: Codable {
    let name: String
    var description: String?
    var thumbnail: Thumbnail?
    let comics: CharactersComicsData
}

struct CharactersData: Codable {
    let results: [Character]
}

struct CharactersModel: Codable {
    let data: CharactersData
}
