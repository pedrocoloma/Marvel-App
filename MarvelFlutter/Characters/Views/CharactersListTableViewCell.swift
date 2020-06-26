//
//  CharactersListTableViewCell.swift
//  MarvelFlutter
//
//  Created by Pedro Felipe Coloma de Araujo on 29/03/20.
//  Copyright © 2020 Pedro Felipe Coloma de Araujo. All rights reserved.
//

import UIKit

class CharactersListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(character: Character) {
        titleLabel.text = character.name.uppercased()
        descriptionLabel.text = character.description
    }
    
}

extension CharactersListTableViewCell: CharactersListCellViewModelViewDelegate {
    func show(error: MarvelError) {
        
    }
    
    func show(image: Data) {
        DispatchQueue.main.async {
            self.backgroundImageView.image = UIImage(data: image)
        }
    }
    
   
}
