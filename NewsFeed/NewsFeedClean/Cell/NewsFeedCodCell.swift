//
//  NewsFeedCodCell.swift
//  NewsFeed
//
//  Created by Александр on 21.01.2021.
//

import Foundation
import UIKit


protocol NewsFeedCodeCellDelegate: class {
    func revealPost(for cell: NewsFeedCodCell)
}



final class NewsFeedCodCell:UITableViewCell {
    
    
  static let reuseId = "NewsFeedCodCell"
    
    weak var delegate: NewsFeedCodeCellDelegate?
    
    
 
    
    // first layer
    let cardView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
     // second layer
    let topView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
//    let postLable: UILabel = {
//       let lable = UILabel()
//        lable.numberOfLines = 0
//        lable.backgroundColor = .clear
//        lable.font = Constants.postLableFont
//        lable.textColor = #colorLiteral(red: 0.1717181504, green: 0.1765684485, blue: 0.1808255613, alpha: 1)
//        return lable
//    }()
    
    let postLable: UITextView = {
        let textView = UITextView()
        textView.font = Constants.postLableFont
        textView.isScrollEnabled = false
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.isEditable = false
        
        let padding = textView.textContainer.lineFragmentPadding
        textView.textContainerInset = UIEdgeInsets.init(top: 0, left: -padding, bottom: 0, right: -padding)
        textView.dataDetectorTypes = UIDataDetectorTypes.all
        
        return textView
    }()
     
    let moreTextButton: UIButton = {
       let botton = UIButton() 
       botton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
       botton.setTitleColor(#colorLiteral(red: 0.4, green: 0.6235294118, blue: 0.831372549, alpha: 1) , for: .normal)
       botton.contentHorizontalAlignment = .left
       botton.contentVerticalAlignment = .center
       botton.setTitle("Показать полностью ...", for: .normal)
   return botton
   }()
    
    let galleryCollectionView = GalleryCollectionView()
    
    
    
    
    
    
    
    
    let postImageView: WebImageView = {
        let image = WebImageView()
        image.backgroundColor = .clear
        return image
    }()
    
   
    
    
    let bottomView:UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    
    
    
    // third layer topView
    
    let iconImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLable: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        lable.numberOfLines = 0
        lable.textColor = #colorLiteral(red: 0.1717181504, green: 0.1765684485, blue: 0.1808255613, alpha: 1)
        return lable
    }()

    
    let dateLable:UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        lable.font = UIFont.systemFont(ofSize: 12 )
        return lable
    }()
    
    
    // third layer bottomView
     
    let likesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    let commentsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    let sharesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
     
    let viewsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    // fourth layer bottomView
    
    
    let likesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "suit.heart")
        imageView.tintColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        return imageView
    }()
    
    let commentsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName:"bubble.left")
        imageView.tintColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        return imageView
    }()
    
    let sharesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "arrowshape.turn.up.right")
        imageView.tintColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        return imageView
    }()
    
    let viewsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "eye.fill")
        imageView.tintColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let likesLable: UILabel = {
       let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.text = "475k "
        lable.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        lable.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        lable.lineBreakMode = .byClipping
        return lable
    }()
    let commentsLable: UILabel = {
       let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        lable.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        lable.lineBreakMode = .byClipping
        return lable
    }()
    let sharesLable: UILabel = {
       let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        lable.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        lable.lineBreakMode = .byClipping
        return lable
    }()
    let viewLable: UILabel = {
       let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        lable.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        lable.lineBreakMode = .byClipping
        return lable
    }()
    
    override func prepareForReuse() {
        iconImageView.set(ImageURL: nil)
        postImageView.set(ImageURL: nil)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        iconImageView.layer.cornerRadius = Constants.topViewHeight / 2
        iconImageView.clipsToBounds = true
        
        backgroundColor = .clear
        selectionStyle = .none
    
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        
        moreTextButton.isUserInteractionEnabled = true
//        moreTextButton.addTarget(self, action: #selector, for: .touchUpInside)

        moreTextButton.addTarget(self, action: #selector(moreTextBottonTouch), for: .touchUpInside)
        
        
        overLayFirstLayer()
        overLaySecondLayer()
        overLayThirdLayer()
        overLayThirdLayerOnBottomView()
        overLayFourthLayerOnBottomViewViews()
        
    }
    
    
    @objc func moreTextBottonTouch() {
        print("123")
        delegate?.revealPost(for: self)
    }
    
     
    
   
    
    
    func set(viewModel:FeedSetViewModel) {

        iconImageView.set(ImageURL: viewModel.iconUrlString)
        nameLable.text = viewModel.name
        dateLable.text = viewModel.date
        postLable.text = viewModel.text
        likesLable.text = viewModel.like
        commentsLable.text = viewModel.comments
        sharesLable.text = viewModel.shares
        viewLable.text = viewModel.views

        
        postLable.frame = viewModel.sizes.postLableFrame
     
        bottomView.frame =  viewModel.sizes.bottomView
        moreTextButton.frame =  viewModel.sizes.moreTextButtonFrame
        

        if let photoAttachement = viewModel.photoAttachements.first, viewModel.photoAttachements.count == 1 {
            postImageView.set(ImageURL: photoAttachement.photoUrlString)
             postImageView.isHidden = false
            galleryCollectionView.isHidden = true
            postImageView.frame = viewModel.sizes.attachementFrame
        } else if  viewModel.photoAttachements.count > 1 {
            galleryCollectionView.frame = viewModel.sizes.attachementFrame
            postImageView.isHidden = true
            galleryCollectionView.isHidden = false
            galleryCollectionView.set(photos: viewModel.photoAttachements)
        } else {
            postImageView.isHidden = true
            galleryCollectionView.isHidden = true
        }
        
        
        
    }
    
    private func overLayFourthLayerOnBottomViewViews() {
        
        likesView.addSubview(likesImage)
        likesView.addSubview(likesLable)
        
        commentsView.addSubview(commentsImage)
        commentsView.addSubview(commentsLable)
        
        sharesView.addSubview(sharesImage)
        sharesView.addSubview(sharesLable)
        
        viewsView.addSubview(viewsImage)
        viewsView.addSubview(viewLable)
        
        helpInFourtLayer(view: likesView, imageView: likesImage, lable: likesLable)
        helpInFourtLayer(view: commentsView, imageView: commentsImage, lable: commentsLable)
        helpInFourtLayer(view: sharesView, imageView: sharesImage, lable: sharesLable)
        helpInFourtLayer(view: viewsView, imageView: viewsImage, lable: viewLable)
    }
    
    private func helpInFourtLayer(view: UIView, imageView: UIImageView,lable: UILabel ) {
        
        // image View constraints
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: Constants.bottomViewViewsIconSize).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Constants.bottomViewViewsIconSize).isActive = true
        // image View constraints
        lable.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        lable.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4).isActive = true
        lable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        
         
    }
    
    private func overLayThirdLayerOnBottomView(){
        bottomView.addSubview(likesView)
        bottomView.addSubview(commentsView)
        bottomView.addSubview(sharesView)
        bottomView.addSubview(viewsView)
        
        // likesView constraints
        
        likesView.anchor(top: bottomView.topAnchor,
                         leading: bottomView.leadingAnchor,
                         bottom: nil,
                         trailing: nil,
                         size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight))
        
        commentsView.anchor(top: bottomView.topAnchor,
                         leading: likesView.trailingAnchor,
                         bottom: nil,
                         trailing: nil,
                         size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight))
        
        sharesView.anchor(top: bottomView.topAnchor,
                         leading: commentsView.trailingAnchor,
                         bottom: nil,
                         trailing: nil,
                         size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight))
        
        viewsView.anchor(top: bottomView.topAnchor,
                         leading: nil,
                         bottom: nil,
                         trailing: bottomView.trailingAnchor,
                         size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight))
        
        
        
        
    }
    
    private func  overLayThirdLayer() {
        topView.addSubview(iconImageView)
        topView.addSubview(nameLable)
        topView.addSubview(dateLable)
        
        // iconImageView constraints
        iconImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor ).isActive = true
        iconImageView.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
      
        // nameLable constraints
        nameLable.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8).isActive = true
        nameLable.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8).isActive = true
        nameLable.topAnchor.constraint(equalTo: topView.topAnchor, constant: 2).isActive = true
        nameLable.heightAnchor.constraint(equalToConstant: Constants.topViewHeight/2 - 2).isActive = true
        
        // date Lable constraints
        dateLable.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8).isActive = true
        dateLable.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8).isActive = true
        dateLable.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -2).isActive = true
        dateLable.heightAnchor.constraint(equalToConstant: 14).isActive = true
        
        
    }
    
    private func  overLaySecondLayer() {
        cardView.addSubview(topView)
        cardView.addSubview(postLable)
        cardView.addSubview(moreTextButton)
        cardView.addSubview(postImageView)
        cardView.addSubview(galleryCollectionView)
        cardView.addSubview(bottomView)
        
        // topView constraints
        
        topView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8).isActive = true
        topView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8).isActive = true
        topView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8).isActive = true
        topView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
        
        // postLable constraints
        
        
        
        // postImageView constraints
        
        
        // moreTextBotton constraints
        
        // galleryCollectionView constraints
        
        // bottomView  constraints
        
    }
    
    private func  overLayFirstLayer() {
        contentView.addSubview(cardView)
        // cardView Constraints
        cardView.fillSuperview(padding: Constants.cardInsets)
        
    }
   
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    
    
}
