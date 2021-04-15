//
//  WebImageView.swift
//  NewsFeed
//
//  Created by Александр on 17.01.2021.
//

import UIKit

class WebImageView: UIImageView {
    
    private var currentUrlStrig: String?
    
     func set(ImageURL:String?) {
        
        currentUrlStrig = ImageURL
        
        guard let ImageURL = ImageURL, let url = URL(string: ImageURL) else {
            self.image = nil
       return }
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url )) {
            self.image = UIImage(data: cachedResponse.data)
            print("From cache")
            return
        }
        print("From internet")
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self](data, response, error) in
             
            DispatchQueue.main.async { [self] in
                if let data = data,let response = response {
                    self?.handleLoadedImage(data: data, response: response)
                }
            }
        }
        dataTask.resume()
        
    }
    
    private func handleLoadedImage(data: Data,response:URLResponse) {
        guard let responseURL = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL ))
        if responseURL.absoluteString == currentUrlStrig {
            self.image = UIImage(data: data)
        }
        
    }
    
    
}
