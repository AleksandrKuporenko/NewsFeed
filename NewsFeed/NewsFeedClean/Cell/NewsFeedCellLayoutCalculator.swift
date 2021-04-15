//
//  NewsFeedCellLauoutCalculator.swift
//  NewsFeed
//
//  Created by Александр on 17.01.2021.
//

import Foundation
import UIKit

protocol FeedCellLayoutCalculatorProtocol  {
    func sizes(postText: String?, photoAttachements : [FeedCellPhotoAttachementViewModel], isFullSizedPost: Bool) -> FeedCeelSizes
}

struct Sizes:FeedCeelSizes {
    
    var postLableFrame: CGRect
    var moreTextButtonFrame: CGRect
    var attachementFrame: CGRect
    var bottomView: CGRect
    var totalHeight: CGFloat
}




final class NewsFeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol  {
  
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth  
    }

    func sizes(postText: String?, photoAttachements : [FeedCellPhotoAttachementViewModel], isFullSizedPost: Bool) -> FeedCeelSizes {
        
        var showMoreTextBotton = false
        
        let cardViewWidth = screenWidth - Constants.cardInsets.left - Constants.cardInsets.right
 
        // MARK: - Работа с postLableFrame
        
        var postLableFrame = CGRect(origin: CGPoint(x: Constants.postLableInsets.left, y: Constants.postLableInsets.top), size: CGSize.zero)
        
        if let text = postText, !text.isEmpty {
            let width = cardViewWidth - Constants.postLableInsets.left - Constants.postLableInsets.right
            var height = text.heigth(widht: width , font: Constants.postLableFont)
        
            let limitHeight = Constants.postLableFont.lineHeight * Constants.minifiedPostLimitLines
            
            if !isFullSizedPost && height > limitHeight {
                height =  Constants.postLableFont.lineHeight * Constants.minifiedPostLines
                showMoreTextBotton = true
            }
            
            
            postLableFrame.size = CGSize(width: width, height: height)
    }
        // MARK: - Работа с moreTextButtonFrame
         
        var moreTextBottonSize =  CGSize.zero
        
        if  showMoreTextBotton {
            moreTextBottonSize = Constants.moreTextButtonSize
        }
        
        let moreTextButtonOrigin  = CGPoint(x: Constants.moreTextButtonInsert.left, y: postLableFrame.maxY )
        
        let moreTextBottonFrame = CGRect(origin: moreTextButtonOrigin, size: moreTextBottonSize)
        
        
        // MARK: - Работа с attechmentFrame
        
        let attachmentTop = postLableFrame.size == CGSize.zero ? Constants.postLableInsets.top : moreTextBottonFrame.maxY + Constants.postLableInsets.bottom
        
        var attachemntFrame = CGRect(origin: CGPoint(x: 0, y: attachmentTop), size: CGSize.zero)
        
        if let attachment = photoAttachements.first {
                        let photoHieght: Float = Float(attachment.height)
                        let photoWidth: Float = Float(attachment.width)
                        let ratio = CGFloat(photoHieght / photoWidth)
            if photoAttachements.count == 1{
                attachemntFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth*ratio )
            } else  if photoAttachements.count > 1  {
                print(" more ")
                var photos = [CGSize]()
                for photo in  photoAttachements {
                    let photoSize = CGSize(width: CGFloat(photo.width), height:  CGFloat(photo.height))
                    photos.append(photoSize)
                }
                
                let rowheight = RowLayout.rowHeightCounter(superviewWidth: cardViewWidth, photosArray: photos)
                
                attachemntFrame.size = CGSize(width: cardViewWidth, height: rowheight!)
            }
        }
        
        
        
        
//        if let attachment = photoAttachement {
//            let photoHieght: Float = Float(attachment.height)
//            let photoWidth: Float = Float(attachment.width)
//            let ratio = CGFloat(photoHieght / photoWidth)
//            attachemntFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth*ratio )
//        }
        
        // MARK: - Работа с attechmentFrame
        
        let bottomViewTop = max(postLableFrame.maxY, attachemntFrame.maxY)
        
        let bottomViewFrame = CGRect(origin: CGPoint(x: 0, y: bottomViewTop), size: CGSize(width: cardViewWidth, height: Constants.bottomViewHeight))
        
        // MARK: - Работа с totalHeight
        let totalHeight =  bottomViewFrame.maxY + Constants.cardInsets.bottom
        
        
        
        return Sizes(postLableFrame: postLableFrame,
                     moreTextButtonFrame: moreTextBottonFrame ,
                     attachementFrame: attachemntFrame,
                     bottomView: bottomViewFrame,
                     totalHeight: totalHeight)
}


}

