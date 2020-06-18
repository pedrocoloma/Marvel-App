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
    let service: ComicsServicing
    var coordinatorDelegate: ComicsListViewModelCoorrdinatorDelegate?
    var viewDelegate: ComicsListViewModelViewDelegate?
    
    init() {
        service = ComicsService()
        getData()
    }
    
    func getData() {
        
        service.fetchComics { (result) in
            switch result {
            case.success(let comics):
                self.comics = comics
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func didSelect(comic: Comic) {
        coordinatorDelegate?.didSelect(comic: comic)
    }
}
