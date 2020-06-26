//
//  ComicsDetailsViewModel.swift
//  MarvelFlutter
//
//  Created by Pedro Felipe Coloma de Araujo on 21/03/20.
//  Copyright © 2020 Pedro Felipe Coloma de Araujo. All rights reserved.
//

import Foundation

protocol ComicsDetailsViewModelViewDelegate: AnyObject {
    func didLoadImageWithSuccess(image: Data)
    func show(error: MarvelError)
}

class ComicsDetailsViewModel {
    
    var comic: Comic?
    var service: ComicsServicing
    var viewDelegate: ComicsDetailsViewModelViewDelegate?
    
    init(_ comic: Comic) {
        self.service = ComicsService()
        self.comic = comic
        getImage()
    }
    
    func getImage() {
        guard let thumbnail = comic?.thumbnail else { return }
        
        service.downloadComicsDetailsImage(thumbnail: thumbnail) { (result) in
            switch result{
            case .success(let image):
                self.viewDelegate?.didLoadImageWithSuccess(image: image)
            case .failure(let error):
                self.viewDelegate?.show(error: error)
            }
        }
    }
}
