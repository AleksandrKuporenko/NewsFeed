//
//  NetworkSevice.swift
//  NewsFeed
//
//  Created by Александр on 13.01.2021.
//

import Foundation

protocol Networking {
    func request(path: String, param: [String :String], completion: @escaping (Data?,Error?) -> Void )
}


final class NetworkSevice: Networking {

    
    
    private let authService: AuthServise
    
    init(authService: AuthServise = SceneDelegate.shared().authService) {
        self.authService = authService
    }
    
  
     
    
    
    private func createDataTask(from request: URLRequest,completion: @escaping (Data?,Error?) -> Void ) -> URLSessionDataTask   {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }

    }
    
    private func url(from path: String, params: [String:String]) -> URL {
        var components = URLComponents()
        
        components.scheme = Api.scheme
        components.host = Api.host
        components.path = path
        components.queryItems = params.map { URLQueryItem(name: $0 , value: $1)}
        
        return components.url!
    }
    
    
    func request(path: String, param: [String : String], completion: @escaping (Data?, Error?) -> Void) {
        
        guard let token = authService.token else { return }
        var allParams = param
        allParams["access_token"] = token 
        allParams["v"] = Api.version
        
         let url = self.url(from: path, params: allParams)
        _ = URLSession.init(configuration: .default)
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
        
        print(url)
    }
}
