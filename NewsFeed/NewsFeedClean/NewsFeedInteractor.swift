//
//  NewsFeedInteractor.swift
//  NewsFeed
//
//  Created by Александр on 15.01.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsFeedBusinessLogic {
  func makeRequest(request: NewsFeed.Model.Request.RequestType)
}

class NewsFeedInteractor: NewsFeedBusinessLogic {

  var presenter: NewsFeedPresentationLogic?
  var service: NewsFeedService?
    
    private var revesledPostIds = [Int]()
    private var feedResponse:  FeedRespose?
    
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkSevice())
  
  func makeRequest(request: NewsFeed.Model.Request.RequestType) {
    if service == nil {
      service = NewsFeedService()
    }
    
    switch request {

  
    case .getNewsFeed:
        fetcher.getFeed { [weak self](feedResponse) in
            
            guard let feedResponse = feedResponse else { return }
      
            self?.feedResponse = feedResponse
            
            self?.presentFeed()
            
        }
    case .revealPostId(postId: let postId):
        revesledPostIds.append(postId)
        
        presentFeed()

       
    case .getUser:
        fetcher.getUser { (userResponse) in
            self.presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentUserInfo(user: userResponse))
        }
    }

}
    
    
    private func presentFeed()  {
        guard  let feedResponse = self.feedResponse else { return }
        
        presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentNewsFeed(feed: feedResponse, revealPostIds: revesledPostIds ))
        
    }

}
