//
//  Movies.swift
//  MoviesStoreApp
//
//  Created by Александр Андреевич Щепелин on 24.10.2022.
//

import Foundation

/// Структура для парсинга результата
struct Results: Codable {
    let results: [Movies]
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
