//
//  GalleryCollectionView.swift
//  NewsFeed
//
//  Created by Александр on 01.02.2021.
//

import Foundation
import UIKit

class  GalleryCollectionView: UICollectionView,UICollectionViewDelegate, UICollectionViewDataSource  {

    var photos  = [FeedCellPhotoAttachementViewModel]()
    
    
    init() {

        let rowlayout = RowLayout()
        super.init(frame: .zero, collectionViewLayout: rowlayout)
        
        
        delegate = self
        dataSource = self
        
        backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        
        register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.reuseId)
    }
    
    func set(photos:[FeedCellPhotoAttachementViewModel]) {
        self.photos = photos
        contentOffset = CGPoint.zero
        reloadData()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.reuseId, for: indexPath) as! GalleryCollectionViewCell
        cell.set(imageURL: photos[indexPath.row].photoUrlString)
        return cell
    }
   

    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



extension GalleryCollectionView: RowLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, photoAtIndexPath indexPath: IndexPath) -> CGSize {
        let width = photos[indexPath.row].width
        let height = photos[indexPath.row].height
        return CGSize(width: width, height: height)
    }
    
    
    
    
    
    
}
