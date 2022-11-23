//
//  Movies.swift
//  MoviesStoreApp
//

/// Структура для парсинга результата
struct Results: Codable {
    let movies: [Movies]

    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

/// Модель фильмов
struct Movies: Codable {
    let poster: String
    let adult: Bool
    let originalTitle: String
    let overview: String
    let releaseDate: String
    let genre: [Int]
    let movieId: Int
    let title: String
    let popularity: Float
    let voteCount: Int
    let video: Bool
    let voteAverage: Float

    enum CodingKeys: String, CodingKey {
        case poster = "poster_path"
        case adult
        case originalTitle = "original_title"
        case overview
        case releaseDate = "release_date"
        case genre = "genre_ids"
        case movieId = "id"
        case title
        case popularity
        case voteCount = "vote_count"
        case video
        case voteAverage = "vote_average"
    }
}

/// Модель конкректного фильма
struct MovieInfo: Codable {
    let poster: String
    let adult: Bool
    let originalTitle: String
    let overview: String
    let releaseDate: String
    let genres: [Genre]
    let movieId: Int
    let title: String
    let popularity: Float
    let voteCount: Int
    let video: Bool
    let voteAverage: Float
    let productionCountries: [ProductionCountry]
    let runtime: Int
    let imdbId: String

    enum CodingKeys: String, CodingKey {
        case poster = "poster_path"
        case adult
        case originalTitle = "original_title"
        case overview
        case releaseDate = "release_date"
        case genres
        case movieId = "id"
        case title
        case popularity
        case voteCount = "vote_count"
        case video
        case voteAverage = "vote_average"
        case productionCountries = "production_countries"
        case runtime
        case imdbId = "imdb_id"
    }
}

/// Жанры
struct Genre: Codable {
    let name: String
}

/// Страна
struct ProductionCountry: Codable {
    let name: String

    enum CodingKeys: String, CodingKey {
        case name
    }
}
