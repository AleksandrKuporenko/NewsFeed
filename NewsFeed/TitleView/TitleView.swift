//
//  TitleView.swift
//  NewsFeed
//
//  Created by Александр on 31.03.2021.
//
 
import Foundation
import UIKit


protocol TitleViewModel {
    var photoUrlString: String? { get }
}

class TitleView: UIView {
    
    private var myTextField = InsetableTextField()
    
    private var myAvatarView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .orange
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(myTextField)
        addSubview(myAvatarView)
        makeConstraints()
    }
    
    
    func set (userViewModel: TitleViewModel) {
        myAvatarView.set(ImageURL: userViewModel.photoUrlString)
    }
    
    
    
    private func makeConstraints() {
//        myAvatar Constraints
        myAvatarView.anchor(top: topAnchor,
                            leading: nil,
                            bottom: nil,
                            trailing: trailingAnchor,
                            padding: UIEdgeInsets(top: 4,
                                                  left: 777,
                                                  bottom: 777,
                                                  right: 4))
        myAvatarView.heightAnchor.constraint(equalTo: myTextField.heightAnchor, multiplier: 1).isActive = true
         
        myAvatarView.widthAnchor.constraint(equalTo: myTextField.heightAnchor, multiplier: 1).isActive = true
        //        myTextField Constraints
        
        
        myTextField.anchor(top: topAnchor,
                           leading: leadingAnchor,
                           bottom: bottomAnchor,
                           trailing: myAvatarView.leadingAnchor,
                           padding: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 12))
         
    }
    
    override var intrinsicContentSize: CGSize {
        
        return UIView.layoutFittingExpandedSize
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myAvatarView.layer.masksToBounds = true 
        myAvatarView.layer.cornerRadius = myAvatarView.frame.width / 2
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
