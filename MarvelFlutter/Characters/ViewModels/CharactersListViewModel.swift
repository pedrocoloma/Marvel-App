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
    let service: CharactersServicing
    var coordinatorDelegate: CharactersListViewModelCoordinatorrDelegate?
    var viewDelegate: CharactersListViewModelViewDelegate?

    init() {
        self.service = CharactersService()
        getData()
    }
    
    func getData() {
        service.fetchCharacters { result in
            switch result {
            case .success(let characters):
                self.characters = characters
                self.viewDelegate?.didLoadCharacctersWithSuccess()
            case .failure(let error):
                print("\(error.localizedDescription)")
            }
        }
    }
    
    func didSelect(character: Character) {
        coordinatorDelegate?.didSelect(character: character)
    }
}
