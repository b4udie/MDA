//
//  MoviesListTableViewCell.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 30.03.2022.
//

import UIKit

final class MoviesListTableViewCell: UITableViewCell {

    @IBOutlet private weak var coverView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var genresLabel: UILabel!
    @IBOutlet private weak var progressView: UIProgressView!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var posterImage: UIImageView!
    @IBOutlet private weak var chevronImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        setupUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterImage.cancelDownloadTask()
        coverView.layer.cornerRadius = 0
    }
    
    func configure(with viewModel: MoviesListViewModel, isFirstCell: Bool) {
        titleLabel.text = viewModel.title
        genresLabel.text = viewModel.genres
        ratingLabel.text = viewModel.rating
        progressView.progress = viewModel.ratingProgressValue
        posterImage.setImage(with: viewModel.posterImageURL)
        
        if isFirstCell {
            coverView.layer.masksToBounds = true
            coverView.layer.cornerRadius = 10
            coverView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
    }
    
    func apply(_ style: Style = Style()) {
        coverView.backgroundColor = style.backgroundColor
        titleLabel.textColor = style.titleColor
        genresLabel.textColor = style.genresColor
        progressView.progressTintColor = style.progressColor
        ratingLabel.textColor = style.ratingColor
    }
}

// MARK: Private methods

private extension MoviesListTableViewCell {
    
    func setupUI() {
        selectionStyle = .none
        
        backgroundColor = .clear
        
        chevronImage.image = chevronImage.image?.withRenderingMode(.alwaysTemplate)
        chevronImage.tintColor = .mda.ebony
    }
}

// MARK: Style

extension MoviesListTableViewCell {
    
    struct Style {
        let backgroundColor: UIColor
        let titleColor: UIColor
        let progressColor: UIColor
        let genresColor: UIColor
        let ratingColor: UIColor
        
        init(
            backgroundColor: UIColor = .mda.eerieBlack,
            titleColor: UIColor = .mda.white,
            progressColor: UIColor = .mda.orange,
            genresColor: UIColor = .mda.philippineGray,
            ratingColor: UIColor = .mda.darkGray
        ) {
            self.backgroundColor = backgroundColor
            self.titleColor = titleColor
            self.progressColor = progressColor
            self.genresColor = genresColor
            self.ratingColor = ratingColor
        }
    }
}
