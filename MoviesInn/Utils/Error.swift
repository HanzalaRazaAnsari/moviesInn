//
//  Error.swift
//  MoviesInn
//
//  Created by Admin on 08/09/2023.
//

import Foundation

public enum RequestError: Error {
    case networkUnreachable
    case noDataFound
    case unknown
    case other(error: String)
    
    var customMessage: String {
        switch self {
        case .networkUnreachable:
            return "Network is Unreachable"
        case .noDataFound:
            return "Data was Not Found in Response"
        case .unknown:
            return "Unknown Error"
        case .other(error: let error):
            return error
        }
    }
}
