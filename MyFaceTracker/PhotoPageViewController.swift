//
//  DisplayPhotoViewController.swift
//  MyFaceTracker
//
//  Created by Philippe Wanner on 01.05.16.
//  Copyright © 2016 Philippe Wanner. All rights reserved.
//

import UIKit

class PhotoPageViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var pageNr: UILabel!
    
    var imageIndex: Int!
    
    var image: UIImage!
    
    var imageTotalCount: Int!
    
    var dateLabelText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = image
        self.pageNr.text = "\(imageIndex+1)/\(imageTotalCount)"
        self.dateLabel.text = dateLabelText
    }
    
    // MARK: Share
    @IBAction func onShare(sender: AnyObject) {
        let activityController = UIActivityViewController(activityItems: ["Check out this face", imageView.image!], applicationActivities: nil)
        presentViewController(activityController, animated: true, completion: nil)
    }
}
