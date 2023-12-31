//
//  WebService.swift
//  MoviesInn
//
//  Created by Admin on 08/09/2023.
//

import Foundation
import Alamofire
import SVProgressHUD

public class WebServiceManager: NSObject{
    
    private var session: Session
    
    public var delegate: WebServiceDelegate!
    
    public var logout: (()->Void)!
    
    public var loaderVC: SVProgressHUD!
    
    private var isNetworkCallInProgress = false
    
    public var errorHandling = (shouldShowErrorDialog : true , errorString:"" , timeToAfterOrderQuotaFull : "")
    
    public static var shared: WebServiceManager = {
        return WebServiceManager()
    }()
    
    
    private override init(){
        loaderVC = SVProgressHUD()
        loaderVC.defaultMaskType = .black
        session = Session()
//        session = Session(serverTrustManager: ServerTrustManager(evaluators: evaluators))
        session.sessionConfiguration.timeoutIntervalForRequest = 20
        session.sessionConfiguration.timeoutIntervalForResource = 20
    }
    
    // MARK: - Generic Request using Async-Await
    @MainActor
    private func showLoader(shouldShowLoader: Bool,
                            networkCallStatus: Bool,
                            message: String) {
        if shouldShowLoader && !SVProgressHUD.isVisible() && !networkCallStatus {
            DispatchQueue.main.async {
                self.delegate?.showLoader(message: message)
            }
        }
    }
    
    private func hideLoader() {
        self.isNetworkCallInProgress = false
        DispatchQueue.main.async {
            self.delegate?.hideLoader { }
        }
    }
    
    private func request(_ url: URLConvertible,
                         method: HTTPMethod = .get,
                         parameters: Parameters? = nil,
                         encoding: ParameterEncoding = URLEncoding.default,
                         headers: HTTPHeaders? = nil,
                         session: Session) async -> AFDataResponse<Any> {
        
        // Request:
        return await withCheckedContinuation { continuation in
            session
                .request(url,
                         method: method,
                         parameters: parameters,
                         encoding: encoding,
                         headers: headers)
                .validate()
                .responseJSON { response in
                    continuation.resume(returning: response)
                }
        }
    }

    
    public func request<T: Decodable>(url: URLConvertible,
                                      httpMethod: HTTPMethod,
                                      parameters: [String: Any]?,
                                      headers: HTTPHeaders? = nil,
                                      requiresToken: Bool = false,
                                      encoding: ParameterEncoding? = JSONEncoding.default,
                                      shouldRefreshToken: Bool = true,
                                      shouldShowLoader: Bool = true,
                                      isNotSSl: Bool = false) async -> Result <T, RequestError> {
        // Before Function Exits:
        defer {
            if shouldShowLoader {
                hideLoader()
            }
        }
        
        // Variables:
        var head: HTTPHeaders?
        var encodingType: ParameterEncoding?
        
        // Check If Network Is Available:
        guard Reachability.isConnectedToNetwork() else {
            DispatchQueue.main.async {
                self.delegate?.showMessage(message: "No Internet Connection", isSuccess: false)
            }
            return .failure(.networkUnreachable)
        }
        
        // Show Loader:
        await showLoader(shouldShowLoader: shouldShowLoader,
                         networkCallStatus: self.isNetworkCallInProgress,
                         message: "")
        
        // Get Token from LocalStorage:

        let authToken = AppManager.sharedInstance.static_token
        guard let encodingType = encoding else { return .failure(.unknown) }
        
        // Set Header:
        if requiresToken {
            head = [
                "Authorization": authToken
            ]
        } else {
            if headers == nil {
                head = [:]
            } else {
                head = headers!
            }
        }
        
        // Network Call -> Ready:
        self.isNetworkCallInProgress = true
        var session = WebServiceManager.shared.session
        
        // Not SSl:
        if isNotSSl {
            session = AF
        }
        
        // Request:
        let queryResponse = await request(url,
                                          method: httpMethod,
                                          parameters: parameters,
                                          encoding: encodingType,
                                          headers: head,
                                          session: session)
        
        return await processResponse(url: url,
                                     httpMethod: httpMethod,
                                     parameters: parameters,
                                     response: queryResponse)
    }
    
    
    private func processResponse<T: Decodable>(url: URLConvertible,
                                               httpMethod: HTTPMethod,
                                               parameters: [String: Any]?,
                                               shouldRefreshToken: Bool = true,
                                               response: AFDataResponse<Any>) async -> Result<T, RequestError> {
        // Handle Result:
        switch response.result {
            
        case .success:
            
            // Check if there is any Data:
            guard let responseData = response.data else {
//                self.delegate.showLoader(message: err.localizedDescription)
                return .failure(.noDataFound)
            }
            
            // Success Response Codes:
            switch response.response?.statusCode {
                
            default:
                // Always Decode by Default:
                do {
                    let objectData = try JSONDecoder().decode(T.self, from: responseData)
                    return .success(objectData)
                } catch {
                    DispatchQueue.main.async {
                        self.delegate.showMessage(message: error.localizedDescription, isSuccess: false)
                    }
//                    self.delegate.showLoader(message: error.localizedDescription)
                    return .failure(.other(error: error.localizedDescription))
                }
            }
            
            // Failure Cases:
        case .failure(let errorFound):
            
            if response.response?.statusCode == 400 {
                guard let data = response.data else {
                    return .failure(.other(error: errorFound.localizedDescription))
                }
            }

            DispatchQueue.main.async {
                self.delegate.showMessage(message: errorFound.localizedDescription, isSuccess: false)
            }
            return .failure(.other(error: errorFound.localizedDescription))
        }
    }
}




