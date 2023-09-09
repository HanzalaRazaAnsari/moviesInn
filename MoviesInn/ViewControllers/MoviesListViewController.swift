//
//  ViewController.swift
//  MoviesInn
//
//  Created by Admin on 07/09/2023.
//

import UIKit
import Combine

class MoviesListViewController: BaseViewController,BaseViewModelProtocol {

    @IBOutlet weak var moviesListTableView:UITableView!
    
    
    
    // MARK: - Variables
    private var cancellables = Set<AnyCancellable>()
    
    

    // MARK: -  Parent Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = MoviesListViewModel(delegate: self)
        prepareComponents()
        guard Reachability.isConnectedToNetwork() else {
            self.showMessageWithNoInternet {
                guard let movie = AppManager.sharedInstance.recentMovie , let id = movie.id else {return}
                self.offlineView(movieID: id)
                return
            }
            return
        }

        self.moviesListTableView.keyboardDismissMode = .onDrag

        networkCall()
    }
    
    @objc func networkCall(){
        getViewModel().getDataFromServer()
        bind()
    }
    
    func offlineView(movieID:Int){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SpecificMovieViewController") as! SpecificMovieViewController
        vc.viewModel = SpecificMovieViewModel(delegate: vc.self, dataProvider: SpecificMovieDataProvider(), movieId: movieID)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func prepareComponents() {
//        self.navigationController?.title = "Movies"
//        self.navigationController?.isNavigationBarHidden = false
        prepareTableView()
    }
    
    
    func bind(){
        getViewModel().$movieList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.moviesListTableView.reloadData()
            }.store(in: &cancellables)
    }
    

    
    // MARK: - Feature Implementation
    private func getViewModel() -> MoviesListViewModel {
        return (self.viewModel as! MoviesListViewModel)
    }

    
    private func prepareTableView(){
        moviesListTableView.register(UINib(nibName: "MovieListCell",
                                        bundle: Bundle(for: MovieListCell.self)),
                                  forCellReuseIdentifier: "cell")
        
        // Properties:
        moviesListTableView.tableFooterView = UIView()
        if #available(iOS 15.0, *) {
            moviesListTableView.sectionHeaderTopPadding = 0.0
        } else {
            // Do Nothing
        }
        
        self.moviesListTableView.delegate = self
        self.moviesListTableView.dataSource = self
    }
    
    @objc func reloadAfterSearch(){
        moviesListTableView.reloadData()
    }
    
    func updateUI() {
    }

}


extension MoviesListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getViewModel().movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieListCell
        cell.configureCell(model: getViewModel().movieList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath) as! MovieListCell
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SpecificMovieViewController") as! SpecificMovieViewController
        vc.viewModel = SpecificMovieViewModel(delegate: vc.self, dataProvider: SpecificMovieDataProvider(), movieId: selectedCell.id)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
}


extension MoviesListViewController : UISearchBarDelegate {
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        guard let text = searchBar.text else {
            searchBar.endEditing(true)
            searchBar.resignFirstResponder()
            return}
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(networkCall), object: searchBar)
        perform(#selector(networkCall), with: searchBar, afterDelay: 0.75)
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.endEditing(true)
        guard let text = searchBar.text else {
            return}
        
        let filteredObjects = getViewModel().movieList.filter { (obj) -> Bool in
            if let title = obj.originalTitle {
            return title.range(of: text, options: .caseInsensitive) != nil
            }
            return false
        }

//        let filteredObjects = getViewModel().movieList.filter { (obj) -> Bool in
//            if let title = obj.originalTitle {
//                return (title.lowercased().contains(text))
//            }
//            return false
//        }
        
        
        getViewModel().movieList = filteredObjects
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(reloadAfterSearch), object: searchBar)
        perform(#selector(reloadAfterSearch), with: searchBar, afterDelay: 0.75)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()

    }
    
}


