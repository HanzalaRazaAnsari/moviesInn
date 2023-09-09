//
//  MoviesListViewModel.swift
//  MoviesInn
//
//  Created by Hanzala Raza on 09/09/2023.
//

import Foundation


class MoviesListViewModel : BaseViewModel, BaseDataProviderProtocol, MovieListViewModelProtocol {
    
    var dataProvider: BaseDataProvider!
    
    
    
    @Published var movieList = [ResultClass]()
    
    var filteredArray = [ResultClass]()

    
    // MARK: - Helper Methods
    private func viewModelProvider() -> MovieListDataProvider {
        guard let vmProvider = dataProvider as? MovieListDataProvider else {
            print("<LOG>[ViewModel][\(MoviesListViewModel.self)]: Provider not Intialized.")
            return MovieListDataProvider()
        }
        return vmProvider
    }
    
    
    // MARK: - Business Logic
    internal func getDataFromServer() {
        // Sequential Requests:
        Task (priority: .background) {
            await getConfiguration()
            await getMovieList()
        }
    }

    
    internal func getMovieList() async {
        
        let movieList = await viewModelProvider().movieList(useCase: .ALL_MOVIES)
        
        
        switch movieList {
        case .success(let success):
            guard let movies = success.results else {return}
            self.movieList = movies
            dump(success)
        
            
        case .failure(let failure):
            print("<LOG>[Network][\(MoviesListViewModel.self)]: \(failure).")
            
        }
    }
    
    internal func getConfiguration() async {
        
        let configuration = await viewModelProvider().configuration()
        
        switch configuration {
        case .success(let success):
            AppManager.sharedInstance.configuration = success
            dump(success)
            
        case .failure(let failure):
            print("<LOG>[Network][\(MoviesListViewModel.self)]: \(failure).")
        }
    }
    
    
    
}
