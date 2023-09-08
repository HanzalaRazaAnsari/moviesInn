//
//  BaseViewModel.swift
//  MoviesInn
//
//  Created by Admin on 08/09/2023.
//

import Foundation

open class BaseViewModel {
    public weak var delegate: BaseViewModelProtocol?
    
    public init(delegate: BaseViewModelProtocol?) {
        self.delegate = delegate
    }
    
    public required init(from decoder: Decoder) throws {
    }
    
    open func encode(to encoder: Encoder) throws {
        
    }
}
