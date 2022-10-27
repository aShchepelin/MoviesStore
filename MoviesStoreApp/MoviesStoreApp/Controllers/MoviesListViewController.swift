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

    private func setupUI() {
        moviesCollection(url: Constants.popularURL)
        view.addSubview(moviesListTableView)
        addSegmentControl()
        setupTableView()
        moviesListTableView.delegate = self
        moviesListTableView.dataSource = self
    }

    private func addSegmentControl() {
        let segmentItems = Constants.moviesCompilation
        moviesCompilationSegmentControl = UISegmentedControl(items: segmentItems)
        view.addSubview(moviesCompilationSegmentControl)
        moviesCompilationSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        moviesCompilationSegmentControl.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        moviesCompilationSegmentControl.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        moviesCompilationSegmentControl.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        moviesCompilationSegmentControl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        moviesCompilationSegmentControl.widthAnchor.constraint(equalToConstant: 250).isActive = true
        moviesCompilationSegmentControl.addTarget(self, action: #selector(segmentControlAction(_:)), for: .valueChanged)
        moviesCompilationSegmentControl.selectedSegmentIndex = 1
    }

    @objc func segmentControlAction(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            moviesCollection(url: Constants.topRatedURL)
        case 1:
            moviesCollection(url: Constants.popularURL)
        case 2:
            moviesCollection(url: Constants.upcomingURL)
        default:
            break
        }
    }

    private func setupTableView() {
        moviesListTableView.register(MoviesListTableViewCell.self,
                                     forCellReuseIdentifier: Identifier.moviesListCellIdentifier)
        moviesListTableView.translatesAutoresizingMaskIntoConstraints = false
        moviesListTableView.topAnchor.constraint(
            equalTo: moviesCompilationSegmentControl.bottomAnchor, constant: 10
        ).isActive = true
        moviesListTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        moviesListTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        moviesListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
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
                print("Error", error)
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
