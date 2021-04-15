//
//  UserResponse.swift
//  NewsFeed
//
//  Created by Александр on 31.03.2021.
//

import Foundation


struct UserResposeWrapper: Decodable {
    let response: [UserRespose]
}

struct UserRespose: Decodable {
    var photo100: String?
}
