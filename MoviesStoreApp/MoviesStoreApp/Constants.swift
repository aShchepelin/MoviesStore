//
//  Constants.swift
//  MoviesStoreApp
//

/// Идентификаторы
enum Identifier {
    static let moviesListCellIdentifier = "MoviesList"
    static let movieInfoCellIdentifier = "MovieInfo"
}

/// Константы с для работы с Api
enum URLRequest {
    static let moviesCompilation = ["Топ Фильмов", "Популярные", "Скоро"]
    static let topRatedRequest = "top_rated"
    static let popularRequest = "popular"
    static let upcomingRequest = "upcoming"
    static let baseURL = "https://api.themoviedb.org/3/movie/"
    static let imageURL = "https://image.tmdb.org/t/p/w500"
    static let apiKey = "?api_key=301bf8bb0ae60538292cdebf5a3021dd&language=ru-RU"
    static let baseImdbURL = "https://www.imdb.com/title/"
    static let imdbTrailerURL = "/?ref_=nv_sr_srsg_0"
    static let creditsURL = "/credits"
}

/// Цвета из ассетов
enum Colors {
    static let greenColorName = "green"
    static let whiteColorName = "white"
    static let grayColorName = "gray"
    static let redColorName = "red"
}
