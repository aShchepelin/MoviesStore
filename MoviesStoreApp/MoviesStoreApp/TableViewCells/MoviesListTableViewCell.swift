//
//  MoviesListTableViewCell.swift
//  MoviesStoreApp
//

import UIKit

/// Ячейка с инфой о фильме
final class MoviesListTableViewCell: UITableViewCell {
    // MARK: - Private Visual Components

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

    private let voteAverageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.textColor = UIColor(named: Colors.whiteColorName)
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
        posterImageView.loadFrom(URLAddress: "\(URLRequest.imageURL) \(model.poster)")
        voteAverageLabel.text = "\(model.voteAverage)"
        originalTitleLabel.text = "\(model.originalTitle), \(model.releaseDate)"

        switch model.voteAverage {
        case 0 ... 5:
            voteAverageLabel.backgroundColor = UIColor(named: Colors.redColorName)
        case 5 ... 7:
            voteAverageLabel.backgroundColor = UIColor(named: Colors.grayColorName)
        case 7 ... 10:
            voteAverageLabel.backgroundColor = UIColor(named: Colors.greenColorName)
        default:
            break
        }
    }

    // MARK: - Private Methods

    private func setupUI() {
        setupVisualComponents()
        setupConstraints()
    }

    private func setupVisualComponents() {
        addSubview(posterImageView)
        addSubview(titleLabel)
        addSubview(originalTitleLabel)
        addSubview(voteAverageLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            posterImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            posterImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            posterImageView.heightAnchor.constraint(equalToConstant: 150),

            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.widthAnchor.constraint(equalToConstant: 250),
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10),

            originalTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            originalTitleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor,
                                                        constant: 10),
            originalTitleLabel.widthAnchor.constraint(equalToConstant: 250),
            originalTitleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 10),

            voteAverageLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor, constant: 10),
            voteAverageLabel.leftAnchor.constraint(equalTo: posterImageView.leftAnchor, constant: -5),
            voteAverageLabel.widthAnchor.constraint(equalToConstant: 45),
            voteAverageLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
