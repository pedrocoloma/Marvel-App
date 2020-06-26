//
//  CharactersListCellViewModel.swift
//  MarvelFlutter
//
//  Created by Pedro Felipe Coloma de Araujo on 29/03/20.
//  Copyright © 2020 Pedro Felipe Coloma de Araujo. All rights reserved.
//

import Foundation

protocol CharactersListCellViewModelViewDelegate: AnyObject {
    func show(image: Data)
    func show(error: MarvelError)
}

class CharactersListCellViewModel {
    
    var character: Character
    var service: CharactersServicing
    var viewDelegate: CharactersListCellViewModelViewDelegate?
    
    init(character: Character) {
        self.character = character
        service = CharactersService()
        getImage()
    }
    
    func getImage() {
        guard let thumbnail = character.thumbnail else { return }
        
        service.downloadThumbnail(thumbnail: thumbnail) { (result) in
            switch result {
            case .success(let image):
                self.viewDelegate?.show(image: image)
            case .failure(let error):
                self.viewDelegate?.show(error: error)
            }
        }
    }
}
