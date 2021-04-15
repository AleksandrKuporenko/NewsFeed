//
//  NetworkDataFetcher.swift
//  NewsFeed
//
//  Created by Александр on 14.01.2021.
//

import Foundation

protocol DataFetcher {
    func getFeed(response: @escaping (FeedRespose?) -> Void)
    func getUser(response: @escaping (UserRespose?) -> Void)
}


struct NetworkDataFetcher:DataFetcher {
   
    private let authService: AuthServise
    let networking:Networking
    
    init(networking: Networking, authService: AuthServise = SceneDelegate.shared().authService) {
        self.networking = networking
        self.authService = authService
    }
    
    func getUser(response: @escaping (UserRespose?) -> Void) {
        
        guard let userId = authService.userId else {return}
        
        let params = ["user_ids": userId, "fields":"photo_100"]
        networking.request(path: Api.user, param: params) { (data, error) in
            if let error = error {
                print("Error received requsting data: \(error.localizedDescription)")
                response(nil)
        }
            
            let decoded = self.decodeJSON(type: UserResposeWrapper.self, from: data)
            response(decoded?.response.first)
            
        }
    }
    
    
    func getFeed(response: @escaping (FeedRespose?) -> Void) {
        let params = ["filters":"post, photo"]
        networking.request(path: Api.newsFeed, param: params) { (data, error) in
            if let error = error {
                print("Error received requsting data: \(error.localizedDescription)")
                response(nil)
            }
            
            let decoded = self.decodeJSON(type: FeedResposeWrapper.self, from: data)
            response(decoded?.response)
        }
   
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T?  {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from , let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
    
    
    
}
