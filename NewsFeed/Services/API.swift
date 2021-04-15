//
//  API.swift
//  NewsFeed
//
//  Created by Александр on 13.01.2021.
//

import Foundation

struct Api{
    static let scheme = "https"
    static let host = "api.vk.com"
    static let version = "5.126"
    
    static let newsFeed = "/method/newsfeed.get"
    static let user = "/method/users.get"
}
