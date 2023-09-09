//
//  MovieListTestCases.swift
//  MoviesInnTests
//
//  Created by Hanzala Raza on 09/09/2023.
//

import XCTest
@testable import MoviesInn

class MovieListTestCases: XCTestCase {


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

}
