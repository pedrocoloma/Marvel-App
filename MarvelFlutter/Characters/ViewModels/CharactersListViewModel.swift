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
    func show(error: MarvelError)
}

class CharactersListViewModel {
    
    var characters: [Character]?
    var service: CharactersServicing
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
                self.viewDelegate?.show(error: error)
            }
        }
    }
    
    func didSelect(character: Character) {
        coordinatorDelegate?.didSelect(character: character)
    }
}
