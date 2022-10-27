//
//  Identifier.swift
//  MoviesStoreApp
//
//  Created by Александр Андреевич Щепелин on 25.10.2022.
//

import Foundation

/// Айдишники
enum Identifier {
    static let moviesListCellIdentifier = "MoviesList"
    static let movieInfoCellIdentifier = "MovieInfo"
}

/// Константы
enum Constants {
    static let moviesCompilation = ["Top Rated", "Popular", "Upcoming"]
    static let topRatedURL = "https://api.themoviedb.org/3/movie/top_rated?api_key=301bf8bb0ae60538292cdebf5a3021dd&language=ru-RU"
    static let popularURL = "https://api.themoviedb.org/3/movie/popular?api_key=301bf8bb0ae60538292cdebf5a3021dd&language=ru-RU"
    static let upcomingURL = "https://api.themoviedb.org/3/movie/upcoming?api_key=301bf8bb0ae60538292cdebf5a3021dd&language=ru-RU"
    static let baseURL = "https://api.themoviedb.org/3/movie/"
    static let apiKey = "?api_key=301bf8bb0ae60538292cdebf5a3021dd&language=ru-RU"
}
