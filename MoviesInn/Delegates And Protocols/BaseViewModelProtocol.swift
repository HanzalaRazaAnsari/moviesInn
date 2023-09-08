//
//  BaseViewModelProtocol.swift
//  MoviesInn
//
//  Created by Admin on 08/09/2023.
//

import Foundation

public protocol BaseViewModelProtocol: AnyObject {
    var viewModel: BaseViewModel! { get set }
    
    func updateUI()
}
