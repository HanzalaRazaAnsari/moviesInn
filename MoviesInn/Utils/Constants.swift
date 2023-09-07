//
//  Constants.swift
//  MoviesInn
//
//  Created by Admin on 07/09/2023.
//

import Foundation


public struct AppEnviroment {
    static var appEnviroment: Enviroment = .PRODUCTION
}

// MARK: Rasayee Endpoints
enum Enviroment {
    
    // Cases:
    case DEVELOPMENT
    case PRODUCTION
    
    func baseURL() -> String {
        return "\(urlProtocol())://\(domain())"
    }
    
    func baseURL(desiredRoute: Routes, useCase: UseCase?) -> String {
        
        // If no UseCase not Available
        guard useCase != nil else {
            return "\(urlProtocol())://\(domain())\(route(desiredRoute: desiredRoute))"
        }
        return "\(urlProtocol())://\(domain())\(route(desiredRoute: desiredRoute))\(useCase!.getUseCase())"
    }
    
    func urlProtocol() -> String {
        switch self {
        case .DEVELOPMENT:
            return "http"
        case .PRODUCTION:
            return "https"

        }
    }
    
    func domain() -> String {
        switch self {
        case .DEVELOPMENT , .PRODUCTION:
            return "//api.themoviedb.org"
        }
    }
    
    func route(desiredRoute: Routes) -> String {
        switch self {
        case .DEVELOPMENT:
            return desiredRoute.getRoute(enviroment: self)
        case .PRODUCTION:
            return desiredRoute.getRoute(enviroment: self)
        }
    }
}



// MARK: Routes
public enum Routes {
    
    // Routes:
    case MOVIES
    
    func getRoute(enviroment: Enviroment) -> String {
        switch enviroment {
        case .DEVELOPMENT, .PRODUCTION:
            switch self {
            case .MOVIES :
                return "/3/movie"
            }
        }
    }
}


// MARK: Usecase
public enum UseCase {
    
    case ALL_MOVIES
    case SPECIFIC_MOVIE(id:Int)

    
    func getUseCase() -> String {
        switch self {
        case .ALL_MOVIES:
            return "/popular"
        case .SPECIFIC_MOVIE(let id):
            return "/\(id)"
        }
    }
}

