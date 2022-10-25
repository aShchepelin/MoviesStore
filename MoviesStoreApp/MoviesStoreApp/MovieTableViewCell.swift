//
//  MovieTableViewCell.swift
//  MoviesStoreApp
//
//  Created by Александр Андреевич Щепелин on 24.10.2022.
//

import UIKit

/// Ячейка с инфой о фильме
final class MovieTableViewCell: UITableViewCell {
    // MARK: - Visual Components

    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()

    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()

    private let originalTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()

    private let popularityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 10)
        return label
    }()

    private let voteAverage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemGreen
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 13)
        return label
    }()

    // MARK: - LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupPosterImageView()
        setupTitleLabel()
        setupOriginalTitleLabel()
        setupVoteAverageLabel()
    }

    // MARK: - Public Methods

    func refreshData(_ model: Movies) {
        titleLabel.text = model.title
        overviewLabel.text = model.overview
//        posterImageView.image = UIImage(named: "testPicture")
        posterImageView.downloaded(from: "https://image.tmdb.org/t/p/w500/kqjL17yufvn9OVLyXYpvtyrFfak.jpg")
        voteAverage.text = "\(model.voteAverage)"
        originalTitleLabel.text = "\(model.originalTitle), \(model.releaseDate)"
    }

    // MARK: - Private Methods

    private func setupPosterImageView() {
        addSubview(posterImageView)
        posterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        posterImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        posterImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3).isActive = true
        posterImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }

    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: -0).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10).isActive = true
    }

    private func setupOriginalTitleLabel() {
        addSubview(originalTitleLabel)
        originalTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -18).isActive = true
        originalTitleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor,
                                                    constant: 10).isActive = true
        originalTitleLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        originalTitleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func setupVoteAverageLabel() {
        addSubview(voteAverage)
        voteAverage.topAnchor.constraint(equalTo: posterImageView.topAnchor, constant: 10).isActive = true
        voteAverage.leftAnchor.constraint(equalTo: posterImageView.leftAnchor, constant: -5).isActive = true
        voteAverage.widthAnchor.constraint(equalToConstant: 45).isActive = true
        voteAverage.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
