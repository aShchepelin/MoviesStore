//
//  MoviesListTableViewCell.swift
//  MoviesStoreApp
//
//  Created by Александр Андреевич Щепелин on 24.10.2022.
//

import UIKit

/// Ячейка с инфой о фильме
final class MoviesListTableViewCell: UITableViewCell {
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
        label.font = .boldSystemFont(ofSize: 17)
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupUI()
    }

    // MARK: - Public Methods

    func refreshData(_ model: Movies) {
        titleLabel.text = model.title
        posterImageView.loadFrom(URLAddress: "https://image.tmdb.org/t/p/w500\(model.poster)")
        voteAverage.text = "\(model.voteAverage)"
        originalTitleLabel.text = "\(model.originalTitle), \(model.releaseDate)"
    }

    // MARK: - Private Methods

    private func setupUI() {
        setupPosterImageView()
        setupTitleLabel()
        setupOriginalTitleLabel()
        setupVoteAverageLabel()
    }

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
        titleLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10).isActive = true
    }

    private func setupOriginalTitleLabel() {
        addSubview(originalTitleLabel)
        originalTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -15).isActive = true
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
