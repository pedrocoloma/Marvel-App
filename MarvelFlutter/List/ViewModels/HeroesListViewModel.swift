//
//  ListViewModel.swift
//  MarvelFlutter
//
//  Created by Pedro Felipe Coloma de Araujo on 08/03/20.
//  Copyright © 2020 Pedro Felipe Coloma de Araujo. All rights reserved.
//

import Foundation

protocol HeroesListViewModelCoorrdinatorDelegate: AnyObject {
    func didSelect()
}

protocol HeroesListViewModelViewDelegate: AnyObject {
    func didLoadComicsWithSuccess()
}

class HeroesListViewModel {
    
    var comics: ComicsModel?
    var myApi = API()
    
    var coordinatorDelegate: HeroesListViewModelCoorrdinatorDelegate?
    var viewDelegate: HeroesListViewModelViewDelegate?
    
    func getData() {
        let api = API()
        api.fetch(endpoint: .characters, callback: { (data, response, error) in
            
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(ComicsModel.self, from: data)
                    
                    self.comics = json
                    self.viewDelegate?.didLoadComicsWithSuccess()
                    
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
            }
        })
    }
    
    init() {
        getData()
    }
    
    func didSelect(row: Int) {
        coordinatorDelegate?.didSelect()
    }
}
