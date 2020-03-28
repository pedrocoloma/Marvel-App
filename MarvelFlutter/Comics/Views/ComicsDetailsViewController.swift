//
//  ComicsDetailsViewController.swift
//  MarvelFlutter
//
//  Created by Pedro Felipe Coloma de Araujo on 08/03/20.
//  Copyright © 2020 Pedro Felipe Coloma de Araujo. All rights reserved.
//

import UIKit

class ComicsDetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var comicsTitleLabel: UILabel!
    @IBOutlet weak var comicsDescriptionLabel: UILabel!
    
    var viewModel: ComicsDetailsViewModel?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }
    
    init(_ viewModel: ComicsDetailsViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        viewModel.viewDelegate = self
    }
    
    func setupUI() {
        if let comicTitle = viewModel?.comic?.title {
            comicsTitleLabel.text = comicTitle
        }
        
        if let comicDescription = viewModel?.comic?.description {
            comicsDescriptionLabel.text = comicDescription
        } else {
            comicsDescriptionLabel.text = "No description available."
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Comic"
        setupUI()
    }
}

extension ComicsDetailsViewController: ComicsDetailsViewModelViewDelegate {
    func didLoadImageWithSuccess(image: Data) {
        DispatchQueue.main.async {
            self.imageView.image = UIImage(data: image)
        }
    }
}
