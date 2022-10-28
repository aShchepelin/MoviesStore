//
//  MovieInfoTableViewCell.swift
//  MoviesStoreApp
//
//  Created by Александр Андреевич Щепелин on 26.10.2022.
//

import SafariServices
import UIKit

/// Делегат для вызова Safari
protocol ShowSafaryDelegate: AnyObject {
    func showMovieInfo()
}

/// Ячейка с информацией о фильме
final class MovieInfoTableViewCell: UITableViewCell {
    // MARK: - Private Enum

    private enum Constants {
        static let imdbLogoName = "IMDBLogo"
        static let hoursText = "ч"
        static let minutesText = "мин"
    }

    // MARK: - Private Visual Components

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
        label.font = .boldSystemFont(ofSize: 22)
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

    private let yearAndGenresLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.textColor = UIColor(named: Colors.grayColorName)
        label.textAlignment = .center
        return label
    }()

    private let countryAndRuntimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = UIColor(named: Colors.grayColorName)
        label.textAlignment = .center
        return label
    }()

    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()

    private let imdbButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: Constants.imdbLogoName), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()

    // MARK: - Public Properties

    weak var delegate: ShowSafaryDelegate?

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError()
    }

    // MARK: - Public Methods

    func refreshData(_ model: MovieInfo) {
        var genres = ""
        var countries = ""
        for item in model.genres {
            genres += " " + item.name
        }

        for item in model.productionCountries {
            countries += " " + item.name
        }
        let year = model.releaseDate.components(separatedBy: "-")
        titleLabel.text = model.title
        posterImageView.loadFrom(URLAddress: "\(URLRequest.imageURL)\(model.poster)")
        yearAndGenresLabel.text = "\(year[0]) \(genres)"
        originalTitleLabel.text = "\(model.originalTitle)"
        countryAndRuntimeLabel.text = "\(countries), \((model.runtime) / 60) " +
            "\(Constants.hoursText) \((model.runtime) % 60) \(Constants.minutesText)"
        overviewLabel.text = model.overview
    }

    // MARK: - Private Methods

    @objc private func showImdbInfoAction() {
        delegate?.showMovieInfo()
    }

    private func setupUI() {
        setupVisualComponents()
        setupConstraints()
        imdbButton.addTarget(self, action: #selector(showImdbInfoAction), for: .touchUpInside)
    }

    private func setupVisualComponents() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(originalTitleLabel)
        contentView.addSubview(yearAndGenresLabel)
        contentView.addSubview(countryAndRuntimeLabel)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(imdbButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            posterImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            posterImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1),
            posterImageView.heightAnchor.constraint(equalToConstant: 400),

            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 250),
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 15),

            originalTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            originalTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            originalTitleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 200),
            originalTitleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 15),

            yearAndGenresLabel.topAnchor.constraint(equalTo: originalTitleLabel.bottomAnchor),
            yearAndGenresLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            yearAndGenresLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 200),
            yearAndGenresLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 15),

            countryAndRuntimeLabel.topAnchor.constraint(equalTo: yearAndGenresLabel.bottomAnchor),
            countryAndRuntimeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            countryAndRuntimeLabel.widthAnchor.constraint(equalToConstant: 200),
            countryAndRuntimeLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 15),

            overviewLabel.topAnchor.constraint(equalTo: countryAndRuntimeLabel.bottomAnchor),
            overviewLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            overviewLabel.widthAnchor.constraint(equalToConstant: 350),
            overviewLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),

            imdbButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 10),
            imdbButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imdbButton.widthAnchor.constraint(equalToConstant: 140),
            imdbButton.heightAnchor.constraint(equalToConstant: 60),
            imdbButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
