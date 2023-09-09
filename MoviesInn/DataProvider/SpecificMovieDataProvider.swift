//
//  SpecificMovieDataProvider.swift
//  MoviesInn
//
//  Created by Hanzala Raza on 09/09/2023.
//

import Foundation
import Alamofire


class SpecificMovieDataProvider: BaseDataProvider {
    
    
    func specificMovie(useCase: UseCase) async -> Result<SpecificMovie, RequestError> {
        
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
    
    
}
