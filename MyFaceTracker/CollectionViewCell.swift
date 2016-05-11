//
//  CellView.swift
//  MyFaceTracker
//
//  Created by Philippe Wanner on 24.04.16.
//  Copyright © 2016 Philippe Wanner. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var image: UIImage!
}