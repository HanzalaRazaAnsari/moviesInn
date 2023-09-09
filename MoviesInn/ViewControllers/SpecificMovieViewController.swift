//
//  SpecificMovieViewController.swift
//  MoviesInn
//
//  Created by Hanzala Raza on 09/09/2023.
//

import UIKit
import Combine

class SpecificMovieViewController: BaseViewController, BaseViewModelProtocol {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var movieVoteCount: UILabel!
    @IBOutlet weak var movieVoteAverage: UILabel!
    @IBOutlet weak var movieStatus: UILabel!
    @IBOutlet weak var movieTagline: UILabel!
    @IBOutlet weak var movieCollection: UILabel!
    @IBOutlet weak var movieRuntime: UILabel!


    // MARK: - Variables
    private var cancellables = Set<AnyCancellable>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard Reachability.isConnectedToNetwork() else {
            guard let movie = AppManager.sharedInstance.recentMovie else {return}
            setData(model: movie)
            return
        }
        
        getViewModel().getDataFromServer()
        bind()
//        setData(model: getViewModel().singleMovie!)
    }
    
    
    func bind(){
        getViewModel().$singleMovie
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let single = self?.getViewModel().singleMovie else {return}
                self?.setData(model: single)
            }.store(in: &cancellables)
    }
    
    func setData(model:SpecificMovie){
        movieName.text = model.originalTitle
        movieDescription.text = model.overview
        movieVoteCount.text = "\(model.voteCount ?? 0)"
        movieVoteAverage.text = "\(model.voteAverage ?? 0)"
        movieRuntime.text = "\(model.runtime ?? 0) min"
        movieStatus.text = model.status
        movieCollection.text = model.belongsToCollection?.name ?? ""
        let url = AppManager.sharedInstance.imageURL(sizes: "w1280", endpoint: model.backdropPath ?? "")
        movieTagline.text = model.tagline
        movieImageView.kingFisherImage(Url: url)
        
    

    }
    
    
    // MARK: - Feature Implementation
    private func getViewModel() -> SpecificMovieViewModel {
        return (self.viewModel as! SpecificMovieViewModel)
    }
    func updateUI() {
        
    }
}
