//
//  ComicsDetailsTableViewCell.swift
//  MarvelFlutter
//
//  Created by Pedro Felipe Coloma de Araujo on 28/03/20.
//  Copyright © 2020 Pedro Felipe Coloma de Araujo. All rights reserved.
//

import UIKit

class ComicsDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var comicImageView: UIImageView!
    @IBOutlet weak var comictitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(comic: Comic) {
        comictitleLabel.text = comic.title
    }
    
}

extension ComicsDetailsTableViewCell: ComicsDetailsTableViewCellViewModelViewDelegate {
    func didLoadImageWithSuccess(image: Data) {
        DispatchQueue.main.async {
            self.comicImageView.image = UIImage(data: image)
        }
    }
}
