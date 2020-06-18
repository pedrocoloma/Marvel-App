//
//  ComicsDetailsTableViewCellViewModel.swift
//  MarvelFlutter
//
//  Created by Pedro Felipe Coloma de Araujo on 28/03/20.
//  Copyright © 2020 Pedro Felipe Coloma de Araujo. All rights reserved.
//

import Foundation

protocol ComicsDetailsTableViewCellViewModelViewDelegate: AnyObject {
    func didLoadImageWithSuccess(image: Data)
}

class ComicsListCellViewModel {
    
    var comic: Comic?
    var service: ComicsServicing
    var viewDelegate: ComicsDetailsTableViewCellViewModelViewDelegate?
    
    init(comic: Comic) {
        self.comic = comic
        service = ComicsService()
        getImage()
    }
    
    func getImage() {
        guard let thumbnail = comic?.thumbnail else { return }
        
        service.downloadComicsDetailsImage(thumbnail: thumbnail) { (result) in
            switch result {
            case.success(let image):
                self.viewDelegate?.didLoadImageWithSuccess(image: image)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
}
