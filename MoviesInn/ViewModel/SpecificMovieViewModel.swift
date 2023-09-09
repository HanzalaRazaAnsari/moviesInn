//
//  SpecificMovieViewModel.swift
//  MoviesInn
//
//  Created by Hanzala Raza on 09/09/2023.
//

import Foundation

class SpecificMovieViewModel : BaseViewModel, BaseDataProviderProtocol,SpecificMovieViewModelProtocol {
    
    
    var dataProvider: BaseDataProvider!
    
    var id = Int()
    
    @Published var singleMovie : SpecificMovie?

    
    // MARK: - Helper Methods
    private func viewModelProvider() -> SpecificMovieDataProvider {
        guard let vmProvider = dataProvider as? SpecificMovieDataProvider else {
            print("<LOG>[ViewModel][\(SpecificMovieViewModel.self)]: Provider not Intialized.")
            return SpecificMovieDataProvider()
        }
        return vmProvider
    }
    
    init(delegate: BaseViewModelProtocol,
         dataProvider: BaseDataProvider!,
         movieId: Int
    ) {
        self.dataProvider = dataProvider
        self.id = movieId
        super.init(delegate: delegate)
    }
    
    public required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    
    // MARK: - Business Logic
    internal func getDataFromServer() {
        // Sequential Requests:
        Task (priority: .background) {
            await specificMovie(id: self.id)
        }
    }

    internal func specificMovie(id: Int) async {
        let movie = await viewModelProvider().specificMovie(useCase: .SPECIFIC_MOVIE(id: id))
        
        
        switch movie {
        case .success(let success):
            self.singleMovie = success
            AppManager.sharedInstance.recentMovie = success
            dump(success)
            
        case .failure(let failure):
            print("<LOG>[Network][\(SpecificMovieViewModel.self)]: \(failure).")
            
        }
    }
    
    
    
    
    
}

