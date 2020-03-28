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

class ComicsDetailsTableViewCellViewModel {
    
    var comic: Comic?
    weak var viewDelegate: ComicsDetailsTableViewCellViewModelViewDelegate?
    
    init(comic: Comic) {
        self.comic = comic
        getImage()
    }
    
    func getImage() {
        guard let thumbnail = comic?.thumbnail else { return }
        
        API.download(endpoint: .comicDetailsImage(thumbnail)) { (data, response, error) in
            if let data = data {
                self.viewDelegate?.didLoadImageWithSuccess(image: data)
            }
        }
    }
}
