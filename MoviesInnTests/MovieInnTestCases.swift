//
//  MovieListTestCases.swift
//  MoviesInnTests
//
//  Created by Hanzala Raza on 09/09/2023.
//

import XCTest
@testable import MoviesInn

 //MARK: Please read this
// Note: there were not many case for test API because if below reasons
// 1) there were not many API
// 2) Token were static because of no authencication of user
// 3) I handled mostly cases during code as were not many loop hole to test them
// 4) API's doesn't had parameters to test the failures

class MovieInnTestCases: XCTestCase {


    func test_SpecificMovieValidation_With_EmptyID_Failure() async{
        
        let specificMovieDataProvider = SpecificMovieDataProvider()
        
        let resultNew = await specificMovieDataProvider.specificMovie(useCase: .SPECIFIC_MOVIE(id: 0))
        
        switch resultNew {
        case .success(let movie) :
            XCTAssertNil(true)
        case .failure :
            XCTAssertTrue(true)
        }
    }
    
    
    func test_Configuration() async {
        let movieListDataProvider = MovieListDataProvider()
        
        let resultNew = await movieListDataProvider.configuration()
        
        switch resultNew {
        case .success(let configuration):
            XCTAssertTrue(true)
            XCTAssertNotNil(configuration)
        case .failure(let error):
            XCTAssertTrue(false)
            XCTAssertNotNil(error)
        }
        
    }

}
