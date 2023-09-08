//
//  ViewController.swift
//  MoviesInn
//
//  Created by Admin on 07/09/2023.
//

import UIKit

class MoviesListViewController: BaseViewController,BaseViewModelProtocol {

    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Movies"
        self.navigationController?.isNavigationBarHidden = false
    }

    
    func updateUI() {
    }

}

