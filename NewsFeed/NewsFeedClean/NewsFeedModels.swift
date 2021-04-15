//
//  NewsFeedModels.swift
//  NewsFeed
//
//  Created by Александр on 15.01.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum NewsFeed {
   
  enum Model {
    struct Request {
      enum RequestType {
        case getNewsFeed
        case getUser
        case revealPostId(postId: Int)
      }
    }
    struct Response {
      enum ResponseType {
        case presentNewsFeed(feed: FeedRespose, revealPostIds: [Int] )
        case presentUserInfo(user:UserRespose?)
        
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayNewsFeed(feed: FeedViewModel)
        case displayUser(userViewModel: UserViewModel)
      }
    }
  }
  
}


struct UserViewModel: TitleViewModel {
    var photoUrlString: String?
    
}

struct  FeedViewModel {
    
    struct Cell: FeedSetViewModel {
        

        var postId: Int
        var name: String
        var date: String
        var text: String?
        var like: String?
        var comments: String?
        var shares: String?
        var views: String?
        var iconUrlString: String
        var photoAttachements: [FeedCellPhotoAttachementViewModel]
        var sizes: FeedCeelSizes 
     
    }
    struct FeedCellPhotoAttachment:FeedCellPhotoAttachementViewModel {
        var photoUrlString: String?
        var width: Int        
        var height: Int
        
        
    }
    
    
    
    let cells: [Cell]
}
