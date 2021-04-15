//
//  NewsFeedPresenter.swift
//  NewsFeed
//
//  Created by Александр on 15.01.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsFeedPresentationLogic {
  func presentData(response: NewsFeed.Model.Response.ResponseType)
}

class NewsFeedPresenter: NewsFeedPresentationLogic {
    
  weak var viewController: NewsFeedDisplayLogic?

    var cellLayoutCalculator: FeedCellLayoutCalculatorProtocol = NewsFeedCellLayoutCalculator()
    
    
    
    
    let dateFormater:DateFormatter = {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_RU")
        dt.dateFormat = "d MMM 'в' HH:mm"
        return dt
    }()
  
  func presentData(response: NewsFeed.Model.Response.ResponseType) {
  
    switch response {

    case .presentNewsFeed(feed: let feed, let revealdedPostIds):
        print(revealdedPostIds)
        let cells = feed.items.map { (feedItem) in
            CellViewModel(from: feedItem, profiles: feed.profiles, groups: feed.groups, revealdedPostIds: revealdedPostIds)
        }

        
        let feedVieModel = FeedViewModel.init(cells: cells)
         
 
    
        viewController?.displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData.displayNewsFeed(feed: feedVieModel ))
        
    case .presentUserInfo(user: let user):
        let userViewModel = UserViewModel.init(photoUrlString: user?.photo100)
        viewController?.displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData.displayUser(userViewModel: userViewModel ))
    }
    
    
  }
    
    private func CellViewModel(from feedItem: FeedItem,profiles:[Profile],groups:[Group], revealdedPostIds: [Int])-> FeedViewModel.Cell {
        
        let profile = self.profile(from: feedItem.sourceId, profiles: profiles, gpoups: groups)
        
        let photoAttachements = self.photoAttachements(feedItem: feedItem)
        
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormater.string(from: date )
        
        let isFullSize = revealdedPostIds.contains { (postId) -> Bool in
            return postId == feedItem.postId
        }
        
        
 
        let sizes = cellLayoutCalculator.sizes(postText: feedItem.text, photoAttachements: photoAttachements, isFullSizedPost: isFullSize )
        
        let postText = feedItem.text?.replacingOccurrences(of: "<br>", with: "\n")
        
        return FeedViewModel.Cell.init(postId: feedItem.postId,
                                       name: profile.name,
                                       date: dateTitle,
                                       text: postText,
                                       like: formattedCounter(feedItem.likes?.count),
                                       comments: formattedCounter(feedItem.comments?.count),
                                       shares: formattedCounter(feedItem.reposts?.count),
                                       views: formattedCounter(feedItem.views?.count),
                                       iconUrlString: profile.photo,
                                       photoAttachements: photoAttachements,
                                       sizes: sizes )
    }
    
    private func formattedCounter(_ counter: Int?) -> String? {
        guard let counter = counter, counter > 0  else {return nil}
        var counterString = String(counter)
        if  4...6 ~= counterString.count {
            counterString = String(counterString.dropLast(3)) + "k"
        } else if counterString.count > 6 {
            counterString = String(counterString.dropLast(6)) + "M"

        }
        return counterString
    }
  
    private func profile(from sourseId: Int, profiles:[Profile],gpoups:[Group])->ProfileRepresentable  {
         
        let profilesOrGroups: [ProfileRepresentable] = sourseId >= 0 ? profiles : gpoups
        let normalSourseId = sourseId >= 0 ? sourseId : -sourseId
        let profileRepresentable = profilesOrGroups.first { (myprofileRepresentable ) -> Bool in
            myprofileRepresentable.id == normalSourseId
        }
        return profileRepresentable!
    }
    
    
    private func photoAttachement (feedItem: FeedItem) -> FeedViewModel.FeedCellPhotoAttachment? {
        guard let photos = feedItem.attachments?.compactMap({ (attachement) in
            attachement.photo
        }), let firstPhoto = photos.first else { return nil  }
        
        return FeedViewModel.FeedCellPhotoAttachment.init(photoUrlString: firstPhoto.srcBIG, width: firstPhoto.width, height: firstPhoto.height)
    }
    
    private func photoAttachements (feedItem: FeedItem) -> [FeedViewModel.FeedCellPhotoAttachment] {
        guard let attachments = feedItem.attachments else { return [] }

           
        return attachments.compactMap { (attechment) -> FeedViewModel.FeedCellPhotoAttachment? in
            guard let photo = attechment.photo else { return nil }
            return FeedViewModel.FeedCellPhotoAttachment.init(photoUrlString: photo.srcBIG, width: photo.width, height: photo.height)
        }
        
        }
    
    
    
    
}
