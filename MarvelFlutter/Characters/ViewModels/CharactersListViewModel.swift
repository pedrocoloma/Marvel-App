//
//  CharactersListViewModel.swift
//  MarvelFlutter
//
//  Created by Pedro Felipe Coloma de Araujo on 29/03/20.
//  Copyright © 2020 Pedro Felipe Coloma de Araujo. All rights reserved.
//

import Foundation

protocol CharactersListViewModelCoordinatorrDelegate {
    func didSelect(character: Character)
}

protocol CharactersListViewModelViewDelegate {
    func didLoadCharacctersWithSuccess()
}

class CharactersListViewModel {
    
    var characters: [Character]?
    var coordinatorDelegate: CharactersListViewModelCoordinatorrDelegate?
    var viewDelegate: CharactersListViewModelViewDelegate?

    init() {
        getData()
    }
    
    func getData() {
        
        API.fetch(endpoint: .characters, callback: { (data, response, error) in
        if let data = data {
            do {
                let json = try JSONDecoder().decode(CharactersModel.self, from: data)
                
                self.characters = json.data.results
                self.viewDelegate?.didLoadCharacctersWithSuccess()
            }
            catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        }})
    }
    
    func didSelect(character: Character) {
        coordinatorDelegate?.didSelect(character: character)
    }
}
