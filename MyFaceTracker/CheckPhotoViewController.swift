//
//  PhotoViewController.swift
//  MyFaceTracker
//
//  Created by Philippe Wanner on 29.04.16.
//  Copyright © 2016 Philippe Wanner. All rights reserved.
//

import UIKit
import CoreData

class CheckPhotoViewController : UIViewController {
    
    @IBOutlet weak var photo: UIImageView!
    
    var image: UIImage!
    
    var sourceController: UIViewController!
    
    var moc : NSManagedObjectContext!
    
    override func viewDidLoad() {
        NSLog("Photo view controller did load")
        super.viewDidLoad()
        photo.image = image
        // create an instance of our managedObjectContext
        moc = DataController().managedObjectContext
    }
    
    @IBAction func onCancel(sender: UIButton) {
        NSLog("Saving cancel")
    }
    
    @IBAction func onSave(sender: UIButton) {
        
        // Set up the entity
        let entityPhoto = NSEntityDescription.insertNewObjectForEntityForName("EntityPhoto", inManagedObjectContext: moc) as! EntityPhoto
        
        // Add data to the entity
        let entityThumbnail = NSEntityDescription.insertNewObjectForEntityForName("EntityThumbnail", inManagedObjectContext: moc) as! EntityThumbnail
        entityThumbnail.thumbnail = image
        
        let entityImage = NSEntityDescription.insertNewObjectForEntityForName("EntityImage", inManagedObjectContext: moc) as! EntityImage
        entityImage.image = image
        
        entityPhoto.relationshipImage = entityImage
        entityPhoto.relationshipThumbnail = entityThumbnail
        entityPhoto.creationDate = NSDate()
        
        // Save the entity
        do {
            try moc.save()
            NSLog("Image saved")
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    
    @IBAction func onBack(sender: UIButton) {
        NSLog("Back")
    }
    
    
}
