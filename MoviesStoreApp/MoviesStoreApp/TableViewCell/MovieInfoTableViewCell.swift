//
//  MovieInfoTableViewCell.swift
//  MoviesStoreApp
//
//  Created by Александр Андреевич Щепелин on 26.10.2022.
//

import UIKit

/// Ячейка с информацией о фильме
final class MovieInfoTableViewCell: UITableViewCell {
    // MARK: - Visual Components

    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 17)
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
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()

    private let popularityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 10)
        return label
    }()

    private let voteAverage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()

    private let voteAverageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        label.backgroundColor = .red
        return label
    }()

    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()

    private let yearAndGenresLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()

    private let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        return button
    }()

    // MARK: - LifeCycle

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupUI()
    }

    // MARK: - Public Methods

    func refreshData(_ model: MovieInfo) {
        let year = model.releaseDate.components(separatedBy: "-")
        titleLabel.text = model.title
        posterImageView.loadFrom(URLAddress: "https://image.tmdb.org/t/p/w500\(model.poster)")
        voteAverage.text = "\(model.voteAverage) \(model.popularity)"
        originalTitleLabel.text = "\(model.originalTitle), \(year[0])"
        overviewLabel.text = model.overview
    }

    // MARK: - Private Methods

    private func setupUI() {
        setupPosterImageView()
        setupTitleLabel()
        setupOriginTitleLabel()
        setupVoteAverageLabel()
        setupOverviewLabel()
    }

    private func setupPosterImageView() {
        addSubview(posterImageView)
        posterImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        posterImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        posterImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        posterImageView.heightAnchor.constraint(equalToConstant: 400).isActive = true
    }

    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }

    private func setupOriginTitleLabel() {
        addSubview(originalTitleLabel)
        originalTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -10).isActive = true
        originalTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        originalTitleLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        originalTitleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func setupVoteAverageLabel() {
        addSubview(voteAverageLabel)
        voteAverageLabel.topAnchor.constraint(equalTo: originalTitleLabel.bottomAnchor, constant: 0).isActive = true
        voteAverageLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        voteAverageLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        voteAverageLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

//    private func setupLikeButton() {
//        addSubview(likeButton)
//        likeButton.translatesAutoresizingMaskIntoConstraints = false
//        likeButton.topAnchor.constraint(equalTo: originalTitleLabel.bottomAnchor, constant: 10).isActive = true
//
//    }

    private func setupOverviewLabel() {
        addSubview(overviewLabel)
        overviewLabel.topAnchor.constraint(equalTo: voteAverageLabel.bottomAnchor, constant: 0).isActive = true
        overviewLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        overviewLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
        overviewLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
}
