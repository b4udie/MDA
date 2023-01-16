//
//  DescriptionTableViewCell.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 31.03.2022.
//

import UIKit

final class DescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
        
    func configure(with model: DescriptionViewModel) {
        descriptionLabel.text = model.description
    }
    
    func apply(_ style: Style = Style()) {
        backgroundColor = style.backgroundColor
        descriptionLabel.textColor = style.descriptionColor
    }
}

// MARK: Style

extension DescriptionTableViewCell {
    
    struct Style {
        let backgroundColor: UIColor
        let descriptionColor: UIColor
        
        init(
            backgroundColor: UIColor = .mda.black,
            descriptionColor: UIColor = .mda.philippineGray
        ) {
            self.backgroundColor = backgroundColor
            self.descriptionColor = descriptionColor
        }
    }
}
