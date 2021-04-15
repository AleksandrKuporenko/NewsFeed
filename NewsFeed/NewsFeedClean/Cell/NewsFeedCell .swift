//
//  NewsFeedCell .swift
//  NewsFeed
//
//  Created by Александр on 16.01.2021.
//

import Foundation
import UIKit

protocol FeedSetViewModel {
    var name: String { get }
    var date: String { get }
    var text: String? { get }
    var like: String? { get }
    var comments: String? { get }
    var shares: String? { get }
    var views: String? { get }
    var iconUrlString : String { get }
    var photoAttachements: [FeedCellPhotoAttachementViewModel] { get }
    var sizes: FeedCeelSizes { get }


    
}


protocol FeedCeelSizes {
    var postLableFrame: CGRect { get }
    var attachementFrame: CGRect { get }
    var bottomView: CGRect { get }
    var totalHeight: CGFloat { get }
    var moreTextButtonFrame: CGRect { get }
    
}

protocol FeedCellPhotoAttachementViewModel {
    var photoUrlString: String?{ get }
    var width: Int { get }
    var height: Int { get }
}

class NewsFeedCell: UITableViewCell  {
    
    static let reuseId = "NewsFeedCell"
    
    @IBOutlet weak var iconImageView: WebImageView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var dateLable: UILabel!
    @IBOutlet weak var postLable: UILabel!
    @IBOutlet weak var likesLable: UILabel!
    @IBOutlet weak var commentsLable: UILabel!
    @IBOutlet weak var sharesLable: UILabel!
    @IBOutlet weak var viewsLable: UILabel!
    @IBOutlet weak var postImageView: WebImageView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    
    override func prepareForReuse() {
        iconImageView.set(ImageURL: nil)
        postImageView.set(ImageURL: nil)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
        iconImageView.clipsToBounds = true
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    
//    func set(viewModel:FeedSetViewModel) {
//        iconImageView.set(ImageURL: viewModel.iconUrlString)
//        nameLable.text = viewModel.name
//        dateLable.text = viewModel.date
//        postLable.text = viewModel.text
//        likesLable.text = viewModel.like
//        commentsLable.text = viewModel.comments
//        sharesLable.text = viewModel.shares
//        viewsLable.text = viewModel.views
//        
//        postLable.frame = viewModel.sizes.postLableFrame
//        postImageView.frame = viewModel.sizes.attachementFrame
//        bottomView.frame =  viewModel.sizes.bottomView
//        
//        
//        if let photoAttachement = viewModel.photoAttachement {
//            postImageView.set(ImageURL: photoAttachement.photoUrlString)
//            postImageView.isHidden = false
//        } else {
//            postImageView.isHidden = true
//        }
//    }
}
 
