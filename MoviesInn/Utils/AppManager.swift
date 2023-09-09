//
//  AppManager.swift
//  MoviesInn
//
//  Created by Admin on 08/09/2023.
//

import Foundation

public class AppManager {
    
    public static var sharedInstance: AppManager = {
       return AppManager()
    }()
    
    
    public var recentMovie: SpecificMovie?{
        didSet{
            guard let encoded = try? JSONEncoder().encode(recentMovie)else{
                return
            }
            UserDefaults.standard.setValue(encoded, forKey: "recentMovie")
        }
    }
    
    private init(){
        if let encoded = UserDefaults.standard.data(forKey: "recentMovie"){
            if let decoded = try? JSONDecoder().decode(SpecificMovie.self, from: encoded){
                recentMovie = decoded
            }
        }
        
        if let encoded = UserDefaults.standard.data(forKey: "configuration"){
            if let decoded = try? JSONDecoder().decode(Configuration.self, from: encoded){
                configuration = decoded
            }
        }
    }
    
    public var configuration : Configuration? {
        didSet{
            guard let encoded = try? JSONEncoder().encode(configuration)else{
                return
            }
            UserDefaults.standard.setValue(encoded, forKey: "configuration")
        }

    }

    public var static_token = "bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0NzQ4MDA2MmE3NjE1MzlkMDkzZWExNWMyM2I4YjY0YiIsInN1YiI6IjY0Zjk1NmFkZGMxY2I0MDBiMGJhMTIxYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.M2WFVb85J9upqO7ysCg2asF-IrC64jgKaZDWsv4TPHo"

    
    public var apiKey = "47480062a761539d093ea15c23b8b64b"
    
    
    func imageURL(sizes:String , endpoint:String) -> String {
        guard let configuration = configuration , let images = configuration.images else { return "" }

        return (images.secureBaseURL ?? "") + (sizes) + (endpoint)
    }
    
}
