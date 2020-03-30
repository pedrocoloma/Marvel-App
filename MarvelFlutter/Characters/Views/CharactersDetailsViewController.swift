//
//  CharactersDetailsViewController.swift
//  MarvelFlutter
//
//  Created by Pedro Felipe Coloma de Araujo on 29/03/20.
//  Copyright © 2020 Pedro Felipe Coloma de Araujo. All rights reserved.
//

import UIKit

class CharactersDetailsViewController: UIViewController {

    
    var viewModel: CharactersDetailsViewModel?
    
    required init?(coder Adecoder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }
    
    init(_ viewModel: CharactersDetailsViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        viewModel.viewDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension CharactersDetailsViewController: CharactersDetailsViewModelViewDelegate {
    
}
