//
//  MovieListDataProvider.swift
//  MoviesInn
//
//  Created by Hanzala Raza on 09/09/2023.
//

import Foundation
import Alamofire


class MovieListDataProvider : BaseDataProvider{
    
    
    func movieList(useCase: UseCase) async -> Result<AllMovies, RequestError> {
        
        // Query Parameters:
        let queryParameters: Parameters = [
            "api_key": AppManager.sharedInstance.apiKey
        ]
        
        // Network Request:
        return await WebServiceManager.shared.request(url: AppEnviroment.appEnviroment.baseURL(desiredRoute: .MOVIES,
                                                      useCase: useCase),
                                                      httpMethod: .get,
                                                      parameters: queryParameters,
                                                      headers: nil,
                                                      requiresToken: true,
                                                      encoding: URLEncoding.default)
    }
    
    
    func configuration() async -> Result<Configuration, RequestError> {
        
        // Query Parameters:
        let queryParameters: Parameters = [
            "api_key": AppManager.sharedInstance.apiKey
        ]
        
        // Network Request:
        return await WebServiceManager.shared.request(url: AppEnviroment.appEnviroment.baseURL(desiredRoute: .CONFIGURATION,
                                                      useCase: nil),
                                                      httpMethod: .get,
                                                      parameters: queryParameters,
                                                      headers: nil,
                                                      requiresToken: true,
                                                      encoding: URLEncoding.default)
    }
    
    
    // MARK: - Cleanup
    deinit {
        print("<LOG>[Memory][\(MovieListDataProvider.self)]: Removed from Memory.")
    }
    
}
