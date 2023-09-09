//
//  MovieListViewModelProtocol.swift
//  MoviesInn
//
//  Created by Hanzala Raza on 09/09/2023.
//

import Foundation


protocol MovieListViewModelProtocol {
    
    func getMovieList() async
    func getConfiguration() async
}
