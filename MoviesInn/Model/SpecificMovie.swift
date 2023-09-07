//
//  SpecificMovie.swift
//  MoviesInn
//
//  Created by Admin on 07/09/2023.
//

import Foundation


public class SpecificMovie: Codable {
    public var adult: Bool?
    public var backdropPath: String?
    public var belongsToCollection: BelongsToCollection?
    public var budget: Int?
    public var genres: [Genre]?
    public var homepage: String?
    public var id: Int?
    public var imdbID: String?
    public var originalLanguage: String?
    public var originalTitle: String?
    public var overview: String?
    public var popularity: Double?
    public var posterPath: String?
    public var productionCompanies: [ProductionCompany]?
    public var productionCountries: [ProductionCountry]?
    public var releaseDate: String?
    public var revenue: Int?
    public var runtime: Int?
    public var spokenLanguages: [SpokenLanguage]?
    public var status: String?
    public var tagline: String?
    public var title: String?
    public var video: Bool?
    public var voteAverage: Double?
    public var voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath
        case belongsToCollection
        case budget
        case genres
        case homepage
        case id
        case imdbID
        case originalLanguage
        case originalTitle
        case overview
        case popularity
        case posterPath
        case productionCompanies
        case productionCountries
        case releaseDate
        case revenue
        case runtime
        case spokenLanguages
        case status
        case tagline
        case title
        case video
        case voteAverage
        case voteCount
    }

    public init(adult: Bool?, backdropPath: String?, belongsToCollection: BelongsToCollection?, budget: Int?, genres: [Genre]?, homepage: String?, id: Int?, imdbID: String?, originalLanguage: String?, originalTitle: String?, overview: String?, popularity: Double?, posterPath: String?, productionCompanies: [ProductionCompany]?, productionCountries: [ProductionCountry]?, releaseDate: String?, revenue: Int?, runtime: Int?, spokenLanguages: [SpokenLanguage]?, status: String?, tagline: String?, title: String?, video: Bool?, voteAverage: Double?, voteCount: Int?) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.belongsToCollection = belongsToCollection
        self.budget = budget
        self.genres = genres
        self.homepage = homepage
        self.id = id
        self.imdbID = imdbID
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.productionCompanies = productionCompanies
        self.productionCountries = productionCountries
        self.releaseDate = releaseDate
        self.revenue = revenue
        self.runtime = runtime
        self.spokenLanguages = spokenLanguages
        self.status = status
        self.tagline = tagline
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
}

// MARK: - BelongsToCollection
public class BelongsToCollection: Codable {
    public var id: Int?
    public var name: String?
    public var posterPath: String?
    public var backdropPath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case posterPath
        case backdropPath
    }

    public init(id: Int?, name: String?, posterPath: String?, backdropPath: String?) {
        self.id = id
        self.name = name
        self.posterPath = posterPath
        self.backdropPath = backdropPath
    }
}

// MARK: - Genre
public class Genre: Codable {
    public var id: Int?
    public var name: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
    }

    public init(id: Int?, name: String?) {
        self.id = id
        self.name = name
    }
}

// MARK: - ProductionCompany
public class ProductionCompany: Codable {
    public var id: Int?
    public var logoPath: String?
    public var name: String?
    public var originCountry: String?

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath
        case name
        case originCountry
    }

    public init(id: Int?, logoPath: String?, name: String?, originCountry: String?) {
        self.id = id
        self.logoPath = logoPath
        self.name = name
        self.originCountry = originCountry
    }
}

// MARK: - ProductionCountry
public class ProductionCountry: Codable {
    public var iso3166_1: String?
    public var name: String?

    enum CodingKeys: String, CodingKey {
        case iso3166_1
        case name
    }

    public init(iso3166_1: String?, name: String?) {
        self.iso3166_1 = iso3166_1
        self.name = name
    }
}

// MARK: - SpokenLanguage
public class SpokenLanguage: Codable {
    public var englishName: String?
    public var iso639_1: String?
    public var name: String?

    enum CodingKeys: String, CodingKey {
        case englishName
        case iso639_1
        case name
    }

    public init(englishName: String?, iso639_1: String?, name: String?) {
        self.englishName = englishName
        self.iso639_1 = iso639_1
        self.name = name
    }
}
