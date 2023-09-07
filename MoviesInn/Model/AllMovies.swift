//
//  AllMovies.swift
//  MoviesInn
//
//  Created by Admin on 07/09/2023.
//

import Foundation

public class AllMovies: Codable {
    public var page: Int?
    public var results: [Result]?
    public var totalPages: Int?
    public var totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages
        case totalResults
    }

    public init(page: Int?, results: [Result]?, totalPages: Int?, totalResults: Int?) {
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
}

// MARK: - Result
public class Result: Codable {
    public var adult: Bool?
    public var backdropPath: String?
    public var genreIDS: [Int]?
    public var id: Int?
    public var originalLanguage: String?
    public var originalTitle: String?
    public var overview: String?
    public var popularity: Double?
    public var posterPath: String?
    public var releaseDate: String?
    public var title: String?
    public var video: Bool?
    public var voteAverage: Double?
    public var voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath
        case genreIDS
        case id
        case originalLanguage
        case originalTitle
        case overview
        case popularity
        case posterPath
        case releaseDate
        case title
        case video
        case voteAverage
        case voteCount
    }

    public init(adult: Bool?, backdropPath: String?, genreIDS: [Int]?, id: Int?, originalLanguage: String?, originalTitle: String?, overview: String?, popularity: Double?, posterPath: String?, releaseDate: String?, title: String?, video: Bool?, voteAverage: Double?, voteCount: Int?) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.genreIDS = genreIDS
        self.id = id
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
}
