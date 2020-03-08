//
//  ListViewModel.swift
//  MarvelFlutter
//
//  Created by Pedro Felipe Coloma de Araujo on 08/03/20.
//  Copyright © 2020 Pedro Felipe Coloma de Araujo. All rights reserved.
//

import Foundation

protocol HeroesListViewModelCoorrdinator {
    func didSelect()
}

class HeroesListViewModel {
    
    var coordinatorDelegate: HeroesListViewModelCoorrdinator?
    
    var heroes = [0]
    
    func didSelect(row: Int) {
        coordinatorDelegate?.didSelect()
    }
}


