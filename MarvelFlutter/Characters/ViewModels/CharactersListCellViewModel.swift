//
//  CharactersListCellViewModel.swift
//  MarvelFlutter
//
//  Created by Pedro Felipe Coloma de Araujo on 29/03/20.
//  Copyright © 2020 Pedro Felipe Coloma de Araujo. All rights reserved.
//

import Foundation

protocol CharactersListCellViewModelViewDelegate: AnyObject {
    func didLoadImageWithSuccess(image: Data)
}

class CharactersListCellViewModel {
    
    var character: Character
    var viewDelegate: CharactersListCellViewModelViewDelegate?
    
    init(character: Character) {
        self.character = character
        getImage()
    }
    
    func getImage() {
        guard let thumbnail = character.thumbnail else { return }
        
        API.download(endpoint: .comicDetailsImage(thumbnail)) { (data, response, error) in
            if let data = data {
                self.viewDelegate?.didLoadImageWithSuccess(image: data)
            }
        }
    }
}
