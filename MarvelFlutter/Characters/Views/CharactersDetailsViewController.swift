//
//  CharactersDetailsViewController.swift
//  MarvelFlutter
//
//  Created by Pedro Felipe Coloma de Araujo on 29/03/20.
//  Copyright © 2020 Pedro Felipe Coloma de Araujo. All rights reserved.
//

import UIKit

class CharactersDetailsViewController: UIViewController {

    @IBOutlet weak var charracterrImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterDescriptionLabel: UILabel!
    
    var viewModel: CharactersDetailsViewModel?
    
    required init?(coder Adecoder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }
    
    init(_ viewModel: CharactersDetailsViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        viewModel.viewDelegate = self
    }
    
    func setupUI() {
        if let characterName = viewModel?.character?.name {
            characterNameLabel.text = characterName
        }
        
        if let characterDescription = viewModel?.character?.description {
            characterNameLabel.text = characterDescription
        } else {
            characterNameLabel.text = "No descrription available."
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Character"
        setupUI()
    }

}

extension CharactersDetailsViewController: CharactersDetailsViewModelViewDelegate {
    func show(error: MarvelError) {
        let alert = UIAlertController(title: "Erro", message: error.localizedDescription, preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
    }
    
    func show(image: Data) {
        DispatchQueue.main.async {
            self.charracterrImageView.image = UIImage(data: image)
        }
    }
}
