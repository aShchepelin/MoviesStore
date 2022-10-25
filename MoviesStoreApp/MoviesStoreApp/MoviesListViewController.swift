//
//  ViewController.swift
//  MoviesStoreApp
//
//  Created by Александр Андреевич Щепелин on 24.10.2022.
//

import UIKit
/// Стартовый экран приложения
final class MoviesListViewController: UIViewController {
    // MARK: - Visual Components

    // MARK: - Public properties

    // MARK: - Private properties

    private let sessionConfiguration = URLSessionConfiguration.default
    private let session = URLSession.shared
    private let movieTableView = UITableView()
    private let decoder = JSONDecoder()
    private var movies: Results?
    private var model: Movies?

    // MARK: - Initializers

    // MARK: - Lifeсycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Public methods

    // MARK: - IBActions

    // MARK: - Private methods

    private func setupUI() {
        view.backgroundColor = .white
        moviesCollection()
        setupTableView()
        movieTableView.delegate = self
        movieTableView.dataSource = self
    }

    private func setupTableView() {
        view.addSubview(movieTableView)
        movieTableView.register(MovieTableViewCell.self,
                                forCellReuseIdentifier: Identifier.movieCellIdentifier)
        movieTableView.translatesAutoresizingMaskIntoConstraints = false
        movieTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        movieTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        movieTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        movieTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

    private func moviesCollection() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=301bf8bb0ae60538292cdebf5a3021dd&language=ru-RU") else { return }
        session.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            do {
                self.movies = try JSONDecoder().decode(Results.self, from: data)
                print(data)
            } catch {
                print("Error", error)
            }
        }.resume()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension MoviesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        movies?.results.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.movieCellIdentifier,
                                                       for: indexPath) as? MovieTableViewCell
        else { return UITableViewCell()
        }
        guard let model = movies?.results[indexPath.row] else { return UITableViewCell() }
        cell.refreshData(model)
        return cell
    }
}
