//
//  Configuration.swift
//  MoviesInn
//
//  Created by Admin on 08/09/2023.
//

import Foundation



public class Configuration: Codable {
    var images: Images?
    var changeKeys: [String]?

    enum CodingKeys: String, CodingKey {
        case images
        case changeKeys = "change_keys"
    }

    init(images: Images?, changeKeys: [String]?) {
        self.images = images
        self.changeKeys = changeKeys
    }
}

// MARK: - Images
public class Images: Codable {
    var baseURL: String?
    var secureBaseURL: String?
    var backdropSizes, logoSizes, posterSizes, profileSizes: [String]?
    var stillSizes: [String]?

    enum CodingKeys: String, CodingKey {
        case baseURL = "base_url"
        case secureBaseURL = "secure_base_url"
        case backdropSizes = "backdrop_sizes"
        case logoSizes = "logo_sizes"
        case posterSizes = "poster_sizes"
        case profileSizes = "profile_sizes"
        case stillSizes = "still_sizes"
    }

    init(baseURL: String?, secureBaseURL: String?, backdropSizes: [String]?, logoSizes: [String]?, posterSizes: [String]?, profileSizes: [String]?, stillSizes: [String]?) {
        self.baseURL = baseURL
        self.secureBaseURL = secureBaseURL
        self.backdropSizes = backdropSizes
        self.logoSizes = logoSizes
        self.posterSizes = posterSizes
        self.profileSizes = profileSizes
        self.stillSizes = stillSizes
    }
}
