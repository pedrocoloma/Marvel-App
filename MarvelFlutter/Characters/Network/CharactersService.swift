//
//  CharactersService.swift
//  MarvelFlutter
//
//  Created by Pedro Felipe Coloma de Araujo on 18/06/20.
//  Copyright © 2020 Pedro Felipe Coloma de Araujo. All rights reserved.
//

import Foundation

protocol CharactersServicing {
    func fetchCharacters(completion: @escaping (Result<[Character], MarvelError>) -> Void)
    func downloadThumbnail(thumbnail: Thumbnail, completion: @escaping (Result<Data, MarvelError>) -> Void)
}

class CharactersService: Service, CharactersServicing {
    func fetchCharacters(completion: @escaping (Result<[Character], MarvelError>) -> Void) {
        
        fetch(endpoint: .characters, callback: { (data, response, error) in
        if let data = data {
            do {
                let json = try JSONDecoder().decode(CharactersModel.self, from: data)
                
                completion(.success(json.data.results))
            }
            catch {
                completion(.failure(.network))
            }
        }})
    }
    
    func downloadThumbnail(thumbnail: Thumbnail, completion: @escaping (Result<Data, MarvelError>) -> Void) {
        
        download(endpoint: .comicDetailsImage(thumbnail)) { (data, response, error) in
            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(.unknown))
            }
        }
    }
    
}
