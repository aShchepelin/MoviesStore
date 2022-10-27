//
//  MovieInfoViewController.swift
//  MoviesStoreApp
//
//  Created by Александр Андреевич Щепелин on 26.10.2022.
//

import UIKit

/// Экран с описанием фильма
final class MovieInfoViewController: UIViewController {
    // MARK: - Visual Components

    private let movieInfoTableView = UITableView()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Public Properties

    var movieInfo: MovieInfo?
    var movieID: Int?

    // MARK: - Private Methods

    private func setupUI() {
        setupTableView()
        movieInfoTableView.delegate = self
        movieInfoTableView.dataSource = self
        moviesCollection()
    }

    private func moviesCollection() {
        guard let url = URL(string: "\(Constants.baseURL + "\(movieID ?? 0)" + Constants.apiKey)")
        else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data else { return }
            do {
                self?.movieInfo = try JSONDecoder().decode(MovieInfo.self, from: data)
                DispatchQueue.main.async {
                    self?.movieInfoTableView.reloadData()
                }
            } catch {
                print("Error", error)
            }
        }.resume()
    }

    private func setupTableView() {
        view.addSubview(movieInfoTableView)
        movieInfoTableView.register(MovieInfoTableViewCell.self,
                                    forCellReuseIdentifier: Identifier.movieInfoCellIdentifier)
        movieInfoTableView.translatesAutoresizingMaskIntoConstraints = false
        movieInfoTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        movieInfoTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        movieInfoTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        movieInfoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension MovieInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.movieInfoCellIdentifier,
                                                       for: indexPath) as? MovieInfoTableViewCell
        else { return UITableViewCell() }
        guard let model = movieInfo else { return UITableViewCell() }
        cell.refreshData(model)
        return cell
    }
}
