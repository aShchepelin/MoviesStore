//
//  MovieInfoViewController.swift
//  MoviesStoreApp
//
//

import SafariServices
import UIKit

/// Экран с описанием фильма
final class MovieInfoViewController: UIViewController {
    // MARK: - Private Visual Components

    private let movieInfoTableView = UITableView()

    // MARK: - Public Properties

    var movieInfo: MovieInfo?
    var movieID: Int?

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private Methods

    private func setupUI() {
        setupTableView()
        movieInfoTableView.delegate = self
        movieInfoTableView.dataSource = self
        moviesCollection()
        setupConstraints()
    }

    private func moviesCollection() {
        guard let url = URL(string: "\(URLRequest.baseURL) \(movieID ?? 0) \(URLRequest.apiKey)")
        else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            do {
                self.movieInfo = try JSONDecoder().decode(MovieInfo.self, from: data)
                DispatchQueue.main.async {
                    self.movieInfoTableView.reloadData()
                }
            } catch {
                print(error)
            }
        }.resume()
    }

    private func setupTableView() {
        view.addSubview(movieInfoTableView)
        movieInfoTableView.register(MovieInfoTableViewCell.self,
                                    forCellReuseIdentifier: Identifier.movieInfoCellIdentifier)
        movieInfoTableView.translatesAutoresizingMaskIntoConstraints = false
        movieInfoTableView.allowsSelection = false
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            movieInfoTableView.topAnchor.constraint(equalTo: view.topAnchor),
            movieInfoTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            movieInfoTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            movieInfoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension MovieInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.movieInfoCellIdentifier,
                                                       for: indexPath) as? MovieInfoTableViewCell,
            let model = movieInfo
        else {
            return UITableViewCell()
        }
        cell.refreshData(model)
        cell.delegate = self
        return cell
    }
}

/// ShowSafaryDelegate
extension MovieInfoViewController: ShowSafaryDelegate {
    func showMovieInfo() {
        guard let model = movieInfo else { return }
        let imdbLink = "\(URLRequest.baseImdbURL)\(model.imdbId)\(URLRequest.imdbTrailerURL)"
        if let url = URL(string: imdbLink) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
}
