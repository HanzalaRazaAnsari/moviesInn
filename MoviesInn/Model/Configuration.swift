//
//  Configuration.swift
//  MoviesInn
//
//  Created by Admin on 08/09/2023.
//

import Foundation



public class Configuration: Codable {
    public var images: Images?
    public var changeKeys: [String]?

    enum CodingKeys: String, CodingKey {
        case images
        case changeKeys
    }

    public init(images: Images?, changeKeys: [String]?) {
        self.images = images
        self.changeKeys = changeKeys
    }
}

// MARK: - Images
public class Images: Codable {
    public var baseURL: String?
    public var secureBaseURL: String?
    public var backdropSizes: [String]?
    public var logoSizes: [String]?
    public var posterSizes: [String]?
    public var profileSizes: [String]?
    public var stillSizes: [String]?

    enum CodingKeys: String, CodingKey {
        case baseURL
        case secureBaseURL
        case backdropSizes
        case logoSizes
        case posterSizes
        case profileSizes
        case stillSizes
    }

    public init(baseURL: String?, secureBaseURL: String?, backdropSizes: [String]?, logoSizes: [String]?, posterSizes: [String]?, profileSizes: [String]?, stillSizes: [String]?) {
        self.baseURL = baseURL
        self.secureBaseURL = secureBaseURL
        self.backdropSizes = backdropSizes
        self.logoSizes = logoSizes
        self.posterSizes = posterSizes
        self.profileSizes = profileSizes
        self.stillSizes = stillSizes
    }
}
