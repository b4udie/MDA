//
//  PosterCell.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 31.03.2022.
//

import UIKit

final class PosterCell: UITableViewCell {

    @IBOutlet private weak var posterImage: UIImageView!
    
    func configure(with model: PosterCellViewModel) {
        posterImage.setImage(with: model.posterImageURL)
    }
}
