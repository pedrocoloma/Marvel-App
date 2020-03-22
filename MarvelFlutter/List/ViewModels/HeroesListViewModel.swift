//
//  ListViewModel.swift
//  MarvelFlutter
//
//  Created by Pedro Felipe Coloma de Araujo on 08/03/20.
//  Copyright © 2020 Pedro Felipe Coloma de Araujo. All rights reserved.
//

import Foundation

protocol HeroesListViewModelCoorrdinatorDelegate: AnyObject {
    func didSelect(comic: Comic)
}

protocol HeroesListViewModelViewDelegate: AnyObject {
    func didLoadComicsWithSuccess()
}

class HeroesListViewModel {
    
    var comics: [Comic]?
    var myApi = API()
    
    var coordinatorDelegate: HeroesListViewModelCoorrdinatorDelegate?
    var viewDelegate: HeroesListViewModelViewDelegate?
    
    init() {
        getData()
    }
    
    func getData() {
        let api = API()
        api.fetch(endpoint: .comics, callback: { (data, response, error) in
            
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(ComicsModel.self, from: data)
                    
                    self.comics = json.data.results
                    self.viewDelegate?.didLoadComicsWithSuccess()
                    
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
            }
        })
    }
    
    func didSelect(row: Int) {
        coordinatorDelegate?.didSelect(comic: (comics?[row])!)
    }
}
