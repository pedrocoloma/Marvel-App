//
//  ComicsService.swift
//  MarvelFlutter
//
//  Created by Pedro Felipe Coloma de Araujo on 18/06/20.
//  Copyright © 2020 Pedro Felipe Coloma de Araujo. All rights reserved.
//

import Foundation

protocol ComicsServicing {
    func fetchComics(completion: @escaping (Result<[Comic]?, MarvelError>) -> Void)
    func downloadComicsDetailsImage(thumbnail: Thumbnail,completion: @escaping (Result<Data, MarvelError>) -> Void)
}

class ComicsService: Service, ComicsServicing {
    func fetchComics(completion: @escaping (Result<[Comic]?, MarvelError>) -> Void) {
        
        fetch(endpoint: .comics, callback: { (data, responser, error) in
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(ComicsModel.self, from: data)

                    completion(.success(json.data.results))
                } catch  {
                    completion(.failure(.parse))
                }
            }
        })
    }
    
    func downloadComicsDetailsImage(thumbnail: Thumbnail,completion: @escaping (Result<Data, MarvelError>) -> Void) {
        download(endpoint: .comicDetailsImage(thumbnail)) { (data, response, error) in
            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(.unknown))
            }
        }
    }
    
}
