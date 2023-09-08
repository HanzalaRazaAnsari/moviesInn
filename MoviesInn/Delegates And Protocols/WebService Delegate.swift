//
//  WebService Delegate.swift
//  MoviesInn
//
//  Created by Admin on 08/09/2023.
//

import Foundation


public protocol WebServiceDelegate {
    func showLoader(message: String)
    func hideLoader(completed: @escaping ()->Void)
    func showMessage(message: String, isSuccess: Bool)
    func showMessage(message: String, isSuccess: Bool, completion: @escaping ()->Void)
}
