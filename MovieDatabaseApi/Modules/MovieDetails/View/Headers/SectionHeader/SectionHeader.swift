//
//  SectionHeader.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 31.03.2022.
//

import UIKit

final class SectionHeader: UITableViewHeaderFooterView {

    @IBOutlet private weak var title: UILabel!
    
    func configure(with model: SectionHeaderViewModel) {
        title.text = model.title
    }
    
    func apply(_ style: Style = Style()) {
        backgroundColor = style.backgroundColor
        title.textColor = style.titleColor
    }
}

// MARK: Style

extension SectionHeader {
    
    struct Style {
        let backgroundColor: UIColor
        let titleColor: UIColor
        
        init(
            backgroundColor: UIColor = .mda.black,
            titleColor: UIColor = .mda.white
        ) {
            self.backgroundColor = backgroundColor
            self.titleColor = titleColor
        }
    }
}
