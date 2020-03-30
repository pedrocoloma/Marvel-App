//
//  ComicsListViewModel.swift
//  MarvelFlutter
//
//  Created by Pedro Felipe Coloma de Araujo on 08/03/20.
//  Copyright © 2020 Pedro Felipe Coloma de Araujo. All rights reserved.
//

import Foundation

protocol ComicsListViewModelCoorrdinatorDelegate: AnyObject {
    func didSelect(comic: Comic)
}

protocol ComicsListViewModelViewDelegate: AnyObject {
    func didLoadComicsWithSuccess()
}

class ComicsListViewModel {
    
    var comics: [Comic]?
    var coordinatorDelegate: ComicsListViewModelCoorrdinatorDelegate?
    var viewDelegate: ComicsListViewModelViewDelegate?
    
    init() {
        getData()
    }
    
    func getData() {
        API.fetch(endpoint: .comics, callback: { (data, response, error) in
            
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
    
    func didSelect(comic: Comic) {
        coordinatorDelegate?.didSelect(comic: comic)
    }
}
