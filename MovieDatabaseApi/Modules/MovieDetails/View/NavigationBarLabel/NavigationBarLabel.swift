//
//  NavigationBarLabel.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 31.03.2022.
//

import UIKit

final class NavigationBarLabel: UIView {

    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var title: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    func configure(voteAverage: Double) {
        title.text = "\(voteAverage) 🏆"
    }
    
    private func setupUI() {
        Bundle.main.loadNibNamed("NavigationBarLabel", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        title.textColor = .mda.philippineGray
        contentView.backgroundColor = .clear
    }
}
