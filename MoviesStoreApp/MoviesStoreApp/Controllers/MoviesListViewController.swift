//
//  MoviesListViewController.swift
//  MoviesStoreApp
//
//  Created by Александр Андреевич Щепелин on 24.10.2022.
//

import UIKit

/// Экран списка фильмов
final class MoviesListViewController: UIViewController {
    // MARK: - Private Visual Components

    private let moviesListTableView = UITableView()

    private var moviesCompilationSegmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl()
        return segmentControl
    }()

    // MARK: - Private properties

    private let sessionConfiguration = URLSessionConfiguration.default
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    private var movieInfo: MovieInfo?
    private var movies: [Movies] = []

    // MARK: - Lifeсycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private methods

    @objc private func segmentControlAction(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            moviesCollection(url: URLRequest.baseURL + URLRequest.topRatedRequest + URLRequest.apiKey)
        case 1:
            moviesCollection(url: URLRequest.baseURL + URLRequest.popularRequest + URLRequest.apiKey)
        case 2:
            moviesCollection(url: URLRequest.baseURL + URLRequest.upcomingRequest + URLRequest.apiKey)
        default:
            break
        }
    }

    private func setupUI() {
        moviesCollection(url: URLRequest.baseURL + URLRequest.popularRequest + URLRequest.apiKey)
        addSegmentControl()
        setupTableView()
        setupConstraints()
        moviesListTableView.delegate = self
        moviesListTableView.dataSource = self
    }

    private func addSegmentControl() {
        let segmentItems = URLRequest.moviesCompilation
        moviesCompilationSegmentControl = UISegmentedControl(items: segmentItems)
        view.addSubview(moviesCompilationSegmentControl)
        moviesCompilationSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        moviesCompilationSegmentControl.addTarget(self, action: #selector(segmentControlAction(_:)), for: .valueChanged)
        moviesCompilationSegmentControl.selectedSegmentIndex = 1
    }

    private func setupTableView() {
        view.addSubview(moviesListTableView)
        moviesListTableView.register(MoviesListTableViewCell.self,
                                     forCellReuseIdentifier: Identifier.moviesListCellIdentifier)
        moviesListTableView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            moviesListTableView.topAnchor.constraint(
                equalTo: moviesCompilationSegmentControl.bottomAnchor, constant: 10
            ),
            moviesListTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            moviesListTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            moviesListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            moviesCompilationSegmentControl.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            moviesCompilationSegmentControl.leftAnchor.constraint(equalTo: view.leftAnchor),
            moviesCompilationSegmentControl.rightAnchor.constraint(equalTo: view.rightAnchor),
            moviesCompilationSegmentControl.heightAnchor.constraint(equalToConstant: 50),
            moviesCompilationSegmentControl.widthAnchor.constraint(equalToConstant: 250),
        ])
    }

    private func moviesCollection(url: String) {
        guard let url = URL(string: url) else { return }
        session.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data else { return }
            do {
                self?.movies = try JSONDecoder().decode(Results.self, from: data).results
                DispatchQueue.main.async {
                    self?.moviesListTableView.reloadData()
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension MoviesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.moviesListCellIdentifier,
                                                       for: indexPath) as? MoviesListTableViewCell
        else { return UITableViewCell() }
        let model = movies[indexPath.row]
        cell.refreshData(model)
        return cell
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieID = movies[indexPath.row].movieId
        let movieInfoViewController = MovieInfoViewController()
        movieInfoViewController.movieID = movieID
        navigationController?.pushViewController(movieInfoViewController, animated: true)
    }
}
