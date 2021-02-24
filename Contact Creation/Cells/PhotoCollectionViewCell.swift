//
//  PhotoCollectionViewCell.swift
//  Contact Creation
//
//  Created by Hiroshi Melendez on 2/24/21.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
 
    static let identifier: String = PhotoCollectionViewCell.description()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
