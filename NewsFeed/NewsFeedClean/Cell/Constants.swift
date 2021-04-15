//
//  Constants.swift
//  NewsFeed
//
//  Created by Александр on 25.01.2021.
//

import Foundation
import UIKit

struct Constants {
    static let cardInsets = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8)
    static let topViewHeight: CGFloat = 36
    static let postLableInsets = UIEdgeInsets(top:8 + Constants.topViewHeight + 8 , left: 8, bottom: 8, right: 8)
    static let postLableFont = UIFont.systemFont(ofSize: 15)
    static let bottomViewHeight: CGFloat = 44
    
    
    static let bottomViewViewHeight: CGFloat = 44
    static let bottomViewViewWidth: CGFloat = 80
    
    static let bottomViewViewsIconSize: CGFloat = 24
    
    static let minifiedPostLimitLines: CGFloat = 8
    static let minifiedPostLines: CGFloat = 6 
    
    static let moreTextButtonInsert = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
    static let moreTextButtonSize = CGSize(width: 170, height: 30 )
    
    
}