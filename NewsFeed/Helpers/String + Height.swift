//
//  String + Height.swift
//  NewsFeed
//
//  Created by Александр on 17.01.2021.
//

import Foundation
import UIKit

extension String {
    
    func heigth(widht: CGFloat, font: UIFont) -> CGFloat {
        let textSize = CGSize(width: widht, height: .greatestFiniteMagnitude )
        let size = self.boundingRect(with: textSize,
                                     options: .usesLineFragmentOrigin,
                                     attributes: [NSAttributedString.Key.font : font],
                                     context: nil)
        return ceil(size.height)
    }

}
