//
//  CharactersDetailsViewModel.swift
//  MarvelFlutter
//
//  Created by Pedro Felipe Coloma de Araujo on 29/03/20.
//  Copyright © 2020 Pedro Felipe Coloma de Araujo. All rights reserved.
//

import Foundation

protocol CharactersDetailsViewModelViewDelegate: AnyObject {
    
}
class CharactersDetailsViewModel {
    
    var character: Character?
    var viewDelegate: CharactersDetailsViewModelViewDelegate?
    
    init(character: Character) {
        self.character = character
    }
}
