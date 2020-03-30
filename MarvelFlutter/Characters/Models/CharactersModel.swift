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
    var resourceURI: String
    var name: String
}

struct Character: Codable {
    var name: String
    var description: String?
    var thumbnail: Thumbnail?
    var comics: CharactersComicsData
}

struct CharactersData: Codable {
    var results: [Character]
}

struct CharactersModel: Codable {
    var data: CharactersData
}
